"""Exercise the real installers using isolated copies and temporary destinations."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


REPO = Path(__file__).resolve().parents[1]
SHELL = os.environ.get('HAN_INSTALLER_SHELL', 'powershell' if os.name == 'nt' else 'bash')


class InstallerTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='han-install-')
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.repo = self.root / 'repo with spaces'
        self.repo.mkdir()
        for filename in ('install.sh', 'install.ps1'):
            shutil.copy2(REPO / filename, self.repo / filename)
        shutil.copytree(REPO / 'skills', self.repo / 'skills')
        self.skills = sorted(p.name for p in (self.repo / 'skills').iterdir() if (p / 'SKILL.md').is_file())
        self.destination = self.root / 'installed skills'

    def run_installer(self, *args, destination=None, succeeds=True):
        destination = destination if destination is not None else self.destination
        if SHELL == 'bash':
            command = [SHELL, str(self.repo / 'install.sh'), '--dest', str(destination)]
        else:
            command = [SHELL, '-NoProfile', '-NonInteractive', '-ExecutionPolicy', 'Bypass',
                       '-File', str(self.repo / 'install.ps1'), '-Dest', str(destination)]
        result = subprocess.run(command + list(args), cwd=self.root, capture_output=True, text=True)
        self.assertEqual(result.returncode == 0, succeeds, result.stdout + result.stderr)
        return result

    def assert_skill_copied(self, name, destination=None):
        destination = destination if destination is not None else self.destination
        source = self.repo / 'skills' / name
        for original in source.rglob('*'):
            if original.is_file():
                self.assertEqual(original.read_bytes(),
                                 (destination / name / original.relative_to(source)).read_bytes())

    def test_install_all_from_another_directory(self):
        # Also exercise hidden supporting files and filenames containing spaces.
        (self.repo / 'skills' / self.skills[0] / '.hidden example').write_text('supporting content')
        self.run_installer()
        self.assertEqual(sorted(p.name for p in self.destination.iterdir()), self.skills)
        for name in self.skills:
            self.assert_skill_copied(name)

    def test_selected_skill(self):
        self.run_installer(self.skills[0])
        self.assertEqual([p.name for p in self.destination.iterdir()], [self.skills[0]])
        self.assert_skill_copied(self.skills[0])

    def test_multiple_skills(self):
        self.run_installer(*self.skills)
        for name in self.skills:
            self.assert_skill_copied(name)

    def test_existing_files_and_local_edits_are_preserved(self):
        self.run_installer()
        modified = self.destination / self.skills[0] / 'SKILL.md'
        modified.write_text('local edits')
        result = self.run_installer()
        self.assertIn('Skipped', result.stdout)
        self.assertEqual(modified.read_text(), 'local edits')
        occupied = self.root / 'occupied'
        occupied.mkdir()
        (occupied / self.skills[0]).write_text('existing file')
        self.run_installer(self.skills[0], destination=occupied)
        self.assertEqual((occupied / self.skills[0]).read_text(), 'existing file')

    def test_invalid_selection_does_not_partially_install(self):
        for invalid in ('missing-skill', '../han-learn', 'HAN-LEARN', '--unknown'):
            with self.subTest(invalid=invalid):
                self.run_installer(self.skills[0], invalid, succeeds=False)
                self.assertFalse(self.destination.exists())

    def test_relative_destination(self):
        self.run_installer(self.skills[0], destination=Path('relative skills'))
        self.assert_skill_copied(self.skills[0], self.root / 'relative skills')

    def test_destination_is_a_file(self):
        self.destination.write_text('preserve this')
        self.run_installer(succeeds=False)
        self.assertEqual(self.destination.read_text(), 'preserve this')

    def test_help_does_not_install(self):
        result = self.run_installer('--help' if SHELL == 'bash' else '-Help')
        self.assertIn('Usage:', result.stdout)
        self.assertFalse(self.destination.exists())

    def test_empty_catalog_fails_cleanly(self):
        shutil.rmtree(self.repo / 'skills')
        (self.repo / 'skills').mkdir()
        self.run_installer(succeeds=False)
        self.assertFalse(self.destination.exists())

    def test_existing_dangling_link_is_preserved(self):
        self.destination.mkdir()
        link = self.destination / self.skills[0]
        try:
            link.symlink_to(self.root / 'missing', target_is_directory=True)
        except OSError as error:
            self.skipTest(f'Symlink creation unavailable: {error}')
        result = self.run_installer(self.skills[0])
        self.assertIn('Skipped', result.stdout)
        self.assertTrue(link.is_symlink())
        self.assertFalse((self.root / 'missing').exists())


if __name__ == '__main__':
    unittest.main(verbosity=2)
