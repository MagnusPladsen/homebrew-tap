cask "gamedev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.3-beta"
  sha256 arm:   "602f047f00e1eebaee80472dcd8da2691b69f3911aae3142e6ad511c2b64644e",
         intel: "5ec43d40660c0e084fe06495acf6e049f4d015a5cb88e347228af90dac16a32d"

  url "https://github.com/MagnusPladsen/dev-studio/releases/download/v#{version}/GameDev-Studio-mac-#{arch}.dmg"
  name "GameDev Studio"
  desc "Free, open source game-dev toolkit"
  homepage "https://gamedev-studio.pladsen.dev/"

  # Both apps share one release per version; the release workflow in MagnusPladsen/dev-studio updates this cask
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-[\w.]+)?)$/i)
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "GameDev Studio.app"

  zap trash: [
    "~/Library/Application Support/GameDev Studio",
    "~/Library/Logs/GameDev Studio",
    "~/Library/Preferences/dev.pladsen.gamedev-studio.plist",
    "~/Library/Saved Application State/dev.pladsen.gamedev-studio.savedState",
  ]

  caveats <<~EOS
    GameDev Studio is not code-signed or notarized by Apple yet, so macOS blocks the first launch.
    Allow it under System Settings → Privacy & Security → Open Anyway, or run:

      xattr -dr com.apple.quarantine "#{appdir}/GameDev Studio.app"

    Projects are saved inside the app. `brew uninstall --zap` deletes them, so export them first.
  EOS
end
