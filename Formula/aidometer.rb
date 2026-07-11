class Aidometer < Formula
  desc "The odometer for your AI — Claude & Codex usage limits in your menu bar"
  homepage "https://github.com/sagar-18/AIdometer"
  license "MIT"
  url "https://github.com/sagar-18/AIdometer/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "12cc4f6200c8ee8bf05282eb630977607b0787657a02925daace6b06e7ef421a"

  # Builds from source (locally compiled → no Gatekeeper quarantine, no signing needed).
  head "https://github.com/sagar-18/AIdometer.git", branch: "main"

  depends_on macos: :ventura   # macOS 13+ (SMAppService)

  def install
    system "bash", "./build.sh"
    prefix.install "AIdometer.app"
    (bin/"aidometer").write <<~SH
      #!/bin/bash
      # Launch detached via LaunchServices so it keeps running after the terminal closes.
      exec open "#{opt_prefix}/AIdometer.app"
    SH
  end

  def caveats
    <<~EOS
      ▸ Check your AI mileage:   aidometer
        or open:       open "#{opt_prefix}/AIdometer.app"
      ▸ Launch at Login is enabled automatically on first run
        (toggle it from the menu-bar dropdown).
      ▸ No gauge in the menu bar? Your menu bar is likely full (macOS hides
        icons that don't fit, especially around the notch) — see
        Troubleshooting in the README. Cmd-drag the icon toward the clock.

      Requires an existing Claude Code login (run `claude` once) and/or a
      Codex CLI login (run `codex` once). Tokens are read locally; the app
      never asks for credentials.

      Unofficial. Not affiliated with Anthropic or OpenAI. Provided "as is",
      no warranty — use at your own risk (see the About item / README).
    EOS
  end

  test do
    assert_predicate opt_prefix/"AIdometer.app/Contents/MacOS/AIdometer", :exist?
  end
end
