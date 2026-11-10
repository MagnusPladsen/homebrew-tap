cask "gamedev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.28-beta"
  sha256 arm:   "cea8f05a8f830b07054c2d48df7b8010c1e4ad9fe933607e81abb133cf64b2b9",
         intel: "d99917b11eaf72c27f13085c1ad566a8c3d840bd950a7c3c8decbb8dc5f7c639"

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
