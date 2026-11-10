cask "gamedev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.31-beta"
  sha256 arm:   "a98331181ecc15762aad30fe6234cad81509cdabd5e969781b7cfe6383a417e9",
         intel: "1b17c50b7d97ad559860139febed4f87370481047df0c4c24c2ac1f05feafa56"

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
