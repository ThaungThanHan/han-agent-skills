# Han Agent Skills 👋

My growing collection of Codex skills for personal projects and everyday work. Grab what you need and make it your own.

## The skills

| Skill | What it does |
| --- | --- |
| [han-learn](HAN-LEARN.md) | Explains how a project works and why, with source links, Mermaid diagrams, and saved lessons. |
| [han-skills-review](HAN-SKILLS-REVIEW.md) | Reviews a skill, scores its quality, and suggests practical improvements. |

## Quick install 🚀

Clone or download this repo, open a terminal in its folder, and run:

| Platform | Install everything | Install one skill |
| --- | --- | --- |
| macOS / Linux | `./install.sh` | `./install.sh han-learn` |
| Windows PowerShell | `.\install.ps1` | `.\install.ps1 han-learn` |

Skills go into `~/.agents/skills`. Existing installations are skipped, so your local edits stay safe. Restart Codex if a skill doesn't show up.

Need a different destination? Run `./install.sh --help` or `.\install.ps1 -Help`.

<details>
<summary>Command won't run?</summary>

On macOS/Linux, try `bash install.sh` if executable permissions are missing.

If Windows blocks the script, run it with a policy override for this process only:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

Using WSL? The Bash installer installs into your Linux home, not your Windows home.

</details>

## Give them a try 💡

In Codex:

```text
$han-learn
$han-learn how does authentication work?
$han-learn ./packages/api

$han-skills-review "$han-learn"
```

**han-learn** uses your current directory unless you name another target. Each request saves a new lesson in the target's `.learn/` folder, starting with a Mermaid architecture overview that GitHub can render.

**han-skills-review** accepts a skill name or path and returns a review with prioritized fixes. It only edits the skill when you ask.
