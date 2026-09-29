cask "dotch" do
  version "0.5.0"
  sha256 "f7d1ba9d7ffbeea6abe42998eeda3fafe8554555caaa78af939880d34aa0498d"

  url "https://github.com/jasonmargin/dotch-releases/releases/download/v#{version}/Dotch-#{version}.zip"
  name "Dotch"
  desc "AeroSpace workspaces in your MacBook notch"
  homepage "https://github.com/jasonmargin/dotch-releases"

  depends_on macos: :sonoma

  app "Dotch.app"

  # Ad-hoc signed (no Developer ID → cannot notarize); strip Gatekeeper
  # quarantine so first launch isn't blocked.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Dotch.app"]
  end

  uninstall quit: "com.jason.dotch"

  zap trash: "~/.config/dotch"

  caveats <<~EOS
    dotch is not notarized (ad-hoc signature); the install strips the
    Gatekeeper quarantine flag automatically. If macOS still blocks it, run:
      xattr -dr com.apple.quarantine /Applications/Dotch.app

    For instant workspace-switch detection, add this to
    ~/.config/aerospace/aerospace.toml and run `aerospace reload-config`:
      exec-on-workspace-change = ["/bin/bash", "-c", "/Applications/Dotch.app/Contents/MacOS/Dotch ping-workspace-change"]
  EOS
end
