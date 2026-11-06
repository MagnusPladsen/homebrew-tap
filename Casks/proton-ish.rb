cask "proton-ish" do
  version "1.0.52"
  sha256 "d0bb70e6b041aefb02df5699d19212a03dd090fe70418a2800c3be4ff0c6d063"

  url "https://github.com/MagnusPladsen/Proton-ish/releases/download/v#{version}/Proton-ish.zip"
  name "Proton-ish"
  desc "Steam Play for the macOS Steam client with Highball's free Wine or CrossOver"
  homepage "https://github.com/MagnusPladsen/Proton-ish"

  # GitHub's release list skips pre-releases; the app's own update feed does not
  livecheck do
    url "https://github.com/MagnusPladsen/Proton-ish/releases/download/update-feed/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Proton-ish.app"

  uninstall quit: "com.magnuspladsen.protonish"

  zap early_script: {
        executable: "/bin/test",
        args:       ["-x", "#{staged_path}/Proton-ish.app/Contents/MacOS/NotProtonApp"],
      },
      script:       {
        executable: "Proton-ish.app/Contents/MacOS/NotProtonApp",
        args:       ["--remove-everything"],
      },
      trash:        [
        "~/Library/Caches/com.magnuspladsen.protonish",
        "~/Library/HTTPStorages/com.magnuspladsen.protonish",
        "~/Library/HTTPStorages/com.magnuspladsen.protonish.binarycookies",
        "~/Library/Preferences/com.magnuspladsen.protonish.plist",
        "~/Library/WebKit/com.magnuspladsen.protonish",
      ]

  caveats <<~EOS
    Proton-ish is not notarized by Apple yet. If macOS refuses to open it, run:

      xattr -dr com.apple.quarantine "#{appdir}/Proton-ish.app"

    or allow it under System Settings → Privacy & Security → Open Anyway.
  EOS
end
