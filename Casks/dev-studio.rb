cask "dev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.19-beta"
  sha256 arm:   "2ab4bd058f967e47df19473565e2704d6aee7dd7c4be199742391db6a72a4cd7",
         intel: "b92f7ab37204c74228540b4f250ecd6c3615c35c34123f99dd2e60731df8a98d"

  url "https://github.com/MagnusPladsen/dev-studio/releases/download/v#{version}/Dev-Studio-mac-#{arch}.dmg"
  name "Dev Studio"
  desc "Free, open source planning toolkit for software projects"
  homepage "https://dev-studio.pladsen.dev/"

  # Both apps share one release per version; the release workflow in MagnusPladsen/dev-studio updates this cask
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-[\w.]+)?)$/i)
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Dev Studio.app"

  zap trash: [
    "~/Library/Application Support/Dev Studio",
    "~/Library/Logs/Dev Studio",
    "~/Library/Preferences/dev.pladsen.dev-studio.plist",
    "~/Library/Saved Application State/dev.pladsen.dev-studio.savedState",
  ]

  caveats <<~EOS
    Dev Studio is not code-signed or notarized by Apple yet, so macOS blocks the first launch.
    Allow it under System Settings → Privacy & Security → Open Anyway, or run:

      xattr -dr com.apple.quarantine "#{appdir}/Dev Studio.app"

    Projects are saved inside the app. `brew uninstall --zap` deletes them, so export them first.
  EOS
end
