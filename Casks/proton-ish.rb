cask "proton-ish" do
  version "1.0.18"
  sha256 "ef1fc35aa6b18c50de3ca980086c618cf7bc4e81dc7c0ed6a30f5d5a032a7109"

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
