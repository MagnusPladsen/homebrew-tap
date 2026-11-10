cask "dev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.28-beta"
  sha256 arm:   "99816575ece1282f4cd6fc5732bc5f3bb0e0cca95bcadc23e8ff61cbbc93a22a",
         intel: "341ae07a0a8cf715021f90654e17db3967c5e956d1a564a412897b4c865c1b07"

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
