# Han Agent Skills 👋

My growing collection of Codex skills for personal projects and everyday work. Grab what you need and make it your own.

## The skills

| Skill | What it does |
| --- | --- |
| [han-learn](HAN-LEARN.md) | Explains how a project works and why, with source links, Mermaid diagrams, and saved lessons. |
| [han-skills-review](HAN-SKILLS-REVIEW.md) | Reviews a skill, scores its quality, and suggests practical improvements. |
| [unrustme](skills/unrustme/SKILL.md) | Creates LeetCode practice scaffolds and reviews solutions with clear explanations. Efficient tool to unrust my brain. |

## Quick install 🚀

With Node.js installed, run this from any folder to install the skills for Codex across your projects:

```bash
npx skills add ThaungThanHan/han-agent-skills -g -a codex
```

To install just one skill, add `--skill han-learn`, `--skill han-skills-review`, or `--skill unrustme`. The command fetches the skills from GitHub, so there is no need to clone the repo. See the [skills CLI](https://github.com/vercel-labs/skills) for other agents and update commands.

If you downloaded the repo, you can also use the local scripts:

| Platform | Install everything | Install one skill |
| --- | --- | --- |
| macOS / Linux | `./install.sh` | `./install.sh han-learn` |
| Windows PowerShell | `.\install.ps1` | `.\install.ps1 han-learn` |

The local scripts put skills in `~/.agents/skills`. Existing installations are skipped, so your local edits stay safe. Restart Codex if a skill doesn't show up.

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

$unrustme create Two Sum in Python
$unrustme review Two Sum
```

**han-learn** uses your current directory unless you name another target. Each request saves a new lesson in the target's `.learn/` folder, starting with a Mermaid architecture overview that GitHub can render.

**han-skills-review** accepts a skill name or path and returns a review with prioritized fixes. It only edits the skill when you ask.

**unrustme** finds problems on [LeetCode](https://leetcode.com/), following your requested title, difficulty, and topics. It stores each problem in `unrustme/<problem-id>-<slug>/` under your current directory. `create` asks for a language if needed, then makes a commented question and solution scaffold in a matching file such as `.py` or `.ts`; `review` writes feedback to that problem's `REVIEW.md`.
