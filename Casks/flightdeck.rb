cask "flightdeck" do
  version "1.10.0"
  sha256 "5646d59ff2fc95d1307ba10ddc881a2463fb269c1113d4351a2a351fc96c042a"

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
