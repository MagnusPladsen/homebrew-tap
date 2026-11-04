cask "gamedev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.17-beta"
  sha256 arm:   "88754677e87875bd05aea1eb163c46f8fff45d7906bd4f81ad6cc12e30eda4b8",
         intel: "17f56a4a88a5dc6e0b9abf8aaff4193f17fa68bb47a4ed0496d4beccc11e4de3"

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
