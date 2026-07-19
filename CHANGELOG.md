# Changelog

All notable changes to AIdometer. Dates are release dates on GitHub.

## [1.4.2] — 2026-07-19
### Added
- **Send test alert** (Settings → Notifications) — fires a sample notification, sound and backlight blink on demand, so you can verify alerts actually reach you (permission, Focus modes, alert style and all).
### Fixed
- **Threshold alerts now survive restarts.** Crossing baselines were kept in memory only, so a limit that crossed a threshold while the app was off — during updates, reboots, or overnight — was silently absorbed as a "new baseline" on the next launch. Baselines are now persisted; the crossing alerts on the next check.
- **Alerts now show while AIdometer is the active app.** macOS hides notifications an app posts about itself while frontmost unless it opts in; that ate alerts landing right after launch (e.g. on the first check after an update relaunches the app).
### Changed
- The keyboard backlight blink is far more noticeable: six full-swing flashes (100% ↔ off) over ~2.5 seconds, instead of three soft flickers in under a second.

## [1.4.1] — 2026-07-12
### Changed
- The Claude Code CLI status line is now on by default (first run only, and only if Claude Code is installed; a later opt-out sticks; any existing status line is backed up).
- Update checks run hourly instead of daily, so new releases are noticed faster.
### Fixed
- The "What's New" summary now appears for existing users after an update, not just future installs.

## [1.4.0] — 2026-07-12
### Added
- **Claude Code CLI status line** — show your Claude/Codex usage limits right in your terminal prompt, alongside model and context %. Enable it in Settings; it merges safely into ~/.claude/settings.json (backing up any existing status line) and reads a local cache, so no credentials ever touch disk. The line is honest about freshness — it shows how old the numbers are.
- **What's New dialog** — after updating, a one-time summary of what changed (never on a fresh install).

## [1.3.0] — 2026-07-12
- **Notch HUD** — new Menu Bar Style: usage readouts hug the MacBook notch (percentage on the left flank, mini gauge on the right), always visible, click to open the menu. Auto-falls back to Compact on displays without a notch.
- **Threshold notifications** — native alerts when a limit crosses a chosen threshold (defaults: 25/50/70/90/95/100%, multi-selectable in Settings → Notifications; once per period; car mode says "Redline!"). On by default. New releases also fire an "Update available" notification, once per version.
- **Keyboard backlight blink** — optional 3-blink pulse when a limit crosses 50/75/90%. Off by default; uses a private macOS framework and degrades to a no-op if unavailable. Enabling it pulses once as a demo.
- This changelog.

## [1.2.1] — 2026-07-12
### Fixed
- Footer icon strip (↻ ⓘ ⏻ ⚙) was invisible on macOS 13–15: icon colors are now baked into the symbols instead of relying on button tinting, which is unreliable inside menus before macOS 26. Also hardens the header provider-toggle mark and the Severity theme icon on Ventura.

## [1.2.0] — 2026-07-11
### Added
- **Car mode**: selecting the AIdometer layout switches the menu to driving vocabulary — limits *refuel*, links read *mileage ↗*, updates arrive as *🔧 Service due*. All other layouts stay literal.
- New app icon: a speedometer with redline zone and needle.
- Trend forecast now reads "at this speed: …".
### Changed
- The AIdometer dial is the default layout for fresh installs.

## [1.1.0] — 2026-07-11
### Added
- **AIdometer layout** — the signature speedometer dial: needle, redline ticks at 70/90%, the limit closest to its ceiling front and center.
- In-app rebrand: header reads AIdometer with provider and plan in the subtitle.
### Changed
- Homebrew formula pins release tarballs — plain `brew install` without `--HEAD`.

## [1.0.0] — 2026-07-11
First release under the AIdometer name — continuation of [claude-usage-bar](https://github.com/sagar-18/claude-usage-bar), renamed when it outgrew tracking only Claude.

Carried over from the claude-usage-bar era (v1.0.0–v1.6.0 there):
- Live Claude limits (session / weekly / per-model) from your existing Claude Code login
- **OpenAI Codex** as a second provider with a one-click brand-mark toggle; plan-aware (Plus/Pro: 5h + weekly, Go: monthly, Business/Enterprise: token & turn activity)
- 9 themes · Classic/Rings/Segments/Trend layouts · 4 menu-bar styles
- Live settings panel (changes apply without the menu closing)
- Honest staleness: expired sign-ins show ⚠︎, never stale numbers passing as live
- Self-updating via GitHub releases; Launch at Login by default
- Native Swift/AppKit, essentially one source file, zero telemetry, MIT
