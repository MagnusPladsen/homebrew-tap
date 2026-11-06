cask "dev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.22-beta"
  sha256 arm:   "5649aff8b0864cb4ca1e3e8c0ef6b4a6fd65243b4a438270e23fd8d81286f733",
         intel: "a52eed1dd3bfbd8879cb48aa05db0432946ecf37ec16fb2858d13240b080583e"

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
