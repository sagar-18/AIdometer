# AIdometer 🏁

**The odometer for your AI — check your mileage before you hit the limit.** A tiny, beautiful macOS menu-bar gauge for your **Claude** and **OpenAI Codex** usage limits — session, weekly, and monthly windows with reset countdowns, live in your menu bar.

```
◐ 5h 2% · wk 4% · Fab 8%      (Claude)
⬡ 5h 12% · wk 34%             (Codex)
```

Click the gauge for the full dashboard: per-limit progress bars, reset countdowns, the active limit, and Codex token/turn activity. Switch between Claude (◐) and Codex (⬡) with the brand-mark toggle in the header — no config, it reads the CLI logins you already have.

---

> [!IMPORTANT]
> **Unofficial. Not affiliated with, or endorsed by, Anthropic or OpenAI.**
> This reads **your own** usage using **your own** local logins — the Claude Code token from your Keychain and/or the Codex CLI token from `~/.codex/auth.json` — by calling **undocumented** endpoints (`api.anthropic.com/api/oauth/usage`, `chatgpt.com/backend-api/wham/…`) that may change or be removed at any time. It polls gently (every 5 min by default, with exponential backoff) to respect rate limits. No data leaves your machine; there is no server, telemetry, or account beyond your existing logins.

> [!WARNING]
> **Use at your own risk — no warranty, no liability.**
> This software is provided **"as is"**, without warranty of any kind. The author and contributors are **not responsible or liable** for anything that happens to your Claude/Anthropic or ChatGPT/OpenAI account — including but not limited to rate limiting, throttling, suspension, or termination — arising from the use of this application or the undocumented endpoints it calls. **By installing or using it, you accept full responsibility.** If you are unsure, don't use it.

---

## Features
- 🔀 **Two providers** — track **Claude** (default) or **OpenAI Codex**; switch instantly with the brand-mark toggle in the dropdown header. Codex adapts to your plan: Plus/Pro show 5-hour + weekly windows, Go shows its monthly window, Business/Enterprise seats (which OpenAI meters centrally, exposing no personal windows) fall back to token/turn activity from the analytics API. The menu-bar glyph tells you which is active: ◐ Claude · ⬡ Codex
- 🎯 Exact percentages — the same numbers as the claude.ai usage page
- 🎨 **9 themes** — Ocean (default), Severity, Claude, Per-Metric, Minimal, Catppuccin, Nord, Dracula, Terminal
- 🧩 **5 dashboard layouts** — Classic, **AIdometer** (the signature speedometer dial: needle, redline ticks at 70/90%, the limit closest to its ceiling front and center), Rings (gauge cluster), Segments (threshold-marked cells), Trend + forecast ("at this pace: 100% ≈ Sat 2 PM", from locally kept history)
- 📏 **5 menu-bar styles** — 5-hour session only (default), Compact (worst limit), Full, a tiny Ring icon (~18px), or the **Notch HUD**: your usage in a pill hugging the MacBook notch (% on one flank, mini gauge on the other), visible even in fullscreen; click it to open the menu. Falls back gracefully on Macs without a notch
- ⏱️ **Reset countdowns** per limit, color-coded status (Healthy → Moderate → High → Critical)
- ⚠️ **Honest about staleness** — an expired sign-in shows `⚠︎` on the icon and a warning row (never stale numbers passing as live), plus an "Updated Xm ago" line and auto-refresh on wake from sleep
- ⚙️ **Live settings** — theme/layout/style changes apply instantly, without the menu closing
- ⌨️ **Claude Code CLI status line** (on by default when Claude Code is installed) — your usage limits right in the terminal prompt next to model and context %: `Opus 4.8 · ctx 34% · ◐ 5h 12% · wk 15% · Fab 24%`. Merges safely into `~/.claude/settings.json` (backs up anything you had), keeps no credentials on disk, and shows the data's age so stale numbers never pass as live. Toggle in Settings
- 🔔 **Threshold notifications** — native alerts when a limit crosses 25/50/70/90/95/100% (each limit tracked independently, once per crossing, sound at the redline). Crossings survive restarts — a limit that crosses while the app is off alerts on the next check. Pick your own thresholds with the chips in Settings → Notifications, and use **Send test alert** there to verify alerts reach you; new releases also notify, once per version
- ⌨️ **Keyboard backlight blink** — six full-brightness keyboard flashes at each threshold crossing, a heads-up you can catch in the corner of your eye during late-night sessions. On by default; the first blink explains itself; toggle in Settings
- 🎉 **What's New after updates** — a one-time summary of what changed, so features never go unnoticed
- 🔁 **Launch at Login** on by default from first run (modern `SMAppService`); toggle anytime
- ⬆️ **In-app updates** — checks GitHub on launch, menu-open, and wake; shows a blue `↑` on the icon and an "Update available…" row; one click rebuilds via brew and relaunches (no Sparkle, no downloaded binaries)
- 🪶 Native Swift/AppKit, essentially one source file, no dependencies, no telemetry

## Requirements
- macOS 13+ (Ventura or later)
- An existing **Claude Code** login (run `claude` once and sign in) and/or a **Codex CLI** login (run `codex` once). Tokens are read locally — the app never asks for credentials.
- Xcode Command Line Tools (`xcode-select --install`) — only needed to build.

## Install

### Homebrew (builds from source — no Gatekeeper prompts)
```bash
brew tap sagar-18/aidometer
brew install aidometer
aidometer            # start it (launches detached; survives terminal close)
```
The formula lives in [sagar-18/homebrew-aidometer](https://github.com/sagar-18/homebrew-aidometer) (and a copy ships in this repo's `Formula/` for older installs). Launch at Login is enabled automatically on first run (toggle it from the menu).

To update later: AIdometer checks GitHub automatically and flags a new release with a blue **↑** on the menu-bar icon plus an **"Update to X.Y.Z available…"** row — one click rebuilds via brew and relaunches. Or manually: `brew update && brew reinstall aidometer`.

### Manual
```bash
git clone https://github.com/sagar-18/AIdometer
cd AIdometer
./build.sh
open AIdometer.app
```

## Troubleshooting

### Installed it, but no gauge in the menu bar?

The app is almost certainly running fine — macOS is just not showing it. Check in this order:

1. **Confirm it's running.** Open **Activity Monitor** and search for `AIdometer` (or run `pgrep -fl AIdometer` in a terminal). If it's not there, start it: `aidometer`.
2. **If it IS running, your menu bar is out of space.** macOS silently hides menu-bar icons that don't fit — no error, no indicator. This is especially common on **notched MacBooks**, where the notch eats the middle of the bar. Quit or hide a few menu-bar apps you don't need and the gauge will appear.
3. **Move it somewhere safer.** Hold **⌘ (Command) and drag** the icon to the right, near the clock — when space runs out, macOS drops the left-most status icons first, so right = priority.
4. **Fullscreen hides everything.** If the frontmost app is fullscreen, the entire menu bar is hidden — move the pointer to the top of the screen or exit fullscreen.
5. **Still cramped?** A menu-bar manager like [Ice](https://github.com/jordanbaird/Ice) (free) or Bartender lets you pin the gauge and tuck the rest away. Also try a narrower style: menu → Settings → **Menu Bar Style**.

### Numbers look stale / icon shows ⚠︎?

Your sign-in token expired (tokens live ~12h and only the CLI that created them can renew). Open a terminal and run `claude` (for Claude) or `codex` (for Codex), let it load, then click **Refresh now** in the menu.

### On Codex, the dashboard shows token activity instead of percentage bars?

That's expected on **Business/Enterprise** seats — OpenAI meters those centrally and exposes no personal rate-limit windows (its own `/status` shows nothing either). AIdometer falls back to showing your **token & turn activity** (Today / Last 7 days) from the analytics API. **Plus, Pro, and Go** accounts get the normal percentage bars.

## Privacy
- Claude: reads the OAuth token from the macOS Keychain item `Claude Code-credentials` (created by Claude Code itself) and talks only to `api.anthropic.com`.
- Codex: reads the OAuth token from `~/.codex/auth.json` (created by the Codex CLI) and talks only to `chatgpt.com`.
- Nothing is logged, stored remotely, or sent anywhere else.
- Fully open source — read [`Sources/AIdometer.swift`](Sources/AIdometer.swift).

## Lineage
AIdometer is the continuation of `claude-usage-bar` (renamed when it outgrew tracking only Claude). Old installs keep working; new installs should use this repo.

## License
[MIT](LICENSE). "Claude" is a trademark of Anthropic; "Codex", "ChatGPT", and the OpenAI logo are trademarks of OpenAI. This project is not affiliated with either company; marks are used only to identify the services being monitored.
