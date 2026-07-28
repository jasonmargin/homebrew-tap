cask "aeronotch" do
  version "0.1.0"
  sha256 "e5044b0c6cb70749570b66bfc69c498838a9fb7ced6a40d1b36b2dbcb54e52d2"

  url "https://github.com/jasonmargin/aeronotch/releases/download/v#{version}/AeroNotch-#{version}.zip"
  name "AeroNotch"
  desc "AeroSpace workspaces in your MacBook notch"
  homepage "https://github.com/jasonmargin/aeronotch"

  depends_on macos: :sonoma

  app "AeroNotch.app"

  uninstall quit: "com.jason.aeronotch"

  zap trash: "~/.config/aeronotch"

  caveats <<~EOS
    aeronotch is not notarized (built with an ad-hoc signature), so
    Gatekeeper will block the first launch. Clear the quarantine flag:
      xattr -dr com.apple.quarantine /Applications/AeroNotch.app
    or approve it under System Settings → Privacy & Security → "Open Anyway".

    For instant workspace-switch detection, add this to
    ~/.config/aerospace/aerospace.toml and run `aerospace reload-config`:
      exec-on-workspace-change = ["/bin/bash", "-c", "/Applications/AeroNotch.app/Contents/MacOS/AeroNotch ping-workspace-change"]
  EOS
end
