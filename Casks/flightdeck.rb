cask "flightdeck" do
  version "1.9.1"
  sha256 "398b6ebc9e98d9bd4e362969ea5b94df259f2e4c0833ded690d059e8444caf78"

  url "https://github.com/MagnusPladsen/flightdeck/releases/download/v#{version}/Flightdeck.zip"
  name "Flightdeck"
  desc "Agent and system monitor for developers, in the menu bar"
  homepage "https://flightdeck.pladsen.dev"

  depends_on macos: :sonoma

  app "Flightdeck.app"

  uninstall quit: "com.magnuspladsen.Flightdeck"

  zap trash: "~/Library/Preferences/com.magnuspladsen.Flightdeck.plist"

  caveats <<~EOS
    Flightdeck is not notarized by Apple yet. If macOS refuses to open it, run:

      xattr -dr com.apple.quarantine "#{appdir}/Flightdeck.app"

    or allow it under System Settings → Privacy & Security → Open Anyway.
  EOS
end
