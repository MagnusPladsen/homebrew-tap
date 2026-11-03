cask "dev-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.1.2-beta"
  sha256 arm:   "ae525fa1c79614955ca53b8de1416c2f7725ec976b0a0f3b76978f60c85df62c",
         intel: "b4e24ed06d65bd164e17dada47d7125b58cc6c147e878e4c5a929140da2000fc"

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
