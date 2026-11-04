cask "flightdeck" do
  version "1.0.5"
  sha256 "ffe1226d7156b8551152f94a7ba0a1ce29cbbc49d030122500a67ea89a0eb33c"

  url "https://github.com/MagnusPladsen/flightdeck/releases/download/v#{version}/Flightdeck.zip"
  name "Flightdeck"
  desc "Agent and system monitor for developers, in the menu bar"
  homepage "https://github.com/MagnusPladsen/flightdeck"

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
