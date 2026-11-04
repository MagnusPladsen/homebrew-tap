cask "dev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.14-beta"
  sha256 arm:   "c6d7883f709d2239081a0e50efd734ecfc28a3c1d68f3a250845655112890119",
         intel: "d0d5f445b30c413b1fb2bd9f00861f7a91e4af2e366f01521dd93760a150d9e5"

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
