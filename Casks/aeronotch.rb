cask "aeronotch" do
  version "0.1.0"
  sha256 "e5044b0c6cb70749570b66bfc69c498838a9fb7ced6a40d1b36b2dbcb54e52d2"

  url "https://github.com/jasonmargin/aeronotch/releases/download/v#{version}/AeroNotch-#{version}.zip"
  name "AeroNotch"
  desc "AeroSpace workspaces in your MacBook notch"
  homepage "https://github.com/jasonmargin/aeronotch"

  depends_on macos: :sonoma

  app "AeroNotch.app"

  # Ad-hoc signed (no Developer ID → cannot notarize); strip Gatekeeper
  # quarantine so first launch isn't blocked.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AeroNotch.app"]
  end

  uninstall quit: "com.jason.aeronotch"

  zap trash: "~/.config/aeronotch"

  caveats <<~EOS
    aeronotch is not notarized (ad-hoc signature); the install strips the
    Gatekeeper quarantine flag automatically. If macOS still blocks it, run:
      xattr -dr com.apple.quarantine /Applications/AeroNotch.app

    For instant workspace-switch detection, add this to
    ~/.config/aerospace/aerospace.toml and run `aerospace reload-config`:
      exec-on-workspace-change = ["/bin/bash", "-c", "/Applications/AeroNotch.app/Contents/MacOS/AeroNotch ping-workspace-change"]
  EOS
end
