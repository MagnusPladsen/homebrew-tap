cask "proton-ish" do
  version "1.0.21"
  sha256 "93fe3f566d6f12a5e6e2e1c22c1daac45b35ed34424af2742bf41efbead255ce"

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
