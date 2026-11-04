# Magnus Pladsen's Homebrew tap

```sh
brew trust magnuspladsen/tap
brew install --cask magnuspladsen/tap/flightdeck
brew install --cask magnuspladsen/tap/proton-ish
brew install --cask magnuspladsen/tap/gamedev-studio
brew install --cask magnuspladsen/tap/dev-studio
```

| Cask | App |
|------|-----|
| `flightdeck` | [Flightdeck](https://github.com/MagnusPladsen/flightdeck): agent and system monitor for developers, in the menu bar |
| `proton-ish` | [Proton-ish](https://github.com/MagnusPladsen/Proton-ish): Steam Play for the macOS Steam client with Highball's free Wine or CrossOver (pre-release) |
| `gamedev-studio` | [GameDev Studio](https://gamedev-studio.pladsen.dev/): free, open source game-dev toolkit (beta) |
| `dev-studio` | [Dev Studio](https://dev-studio.pladsen.dev/): free, open source planning toolkit for software projects (beta) |

Newer Homebrew versions only load casks from taps you trust, hence `brew trust` first.

Each app's own release workflow updates its cask, so `brew upgrade` picks up new versions. GameDev Studio and
Dev Studio are released together from [MagnusPladsen/dev-studio](https://github.com/MagnusPladsen/dev-studio) on
every merge to `main`.

## Unsigned apps

Flightdeck, GameDev Studio and Dev Studio are not notarized by Apple yet, so macOS blocks them the first time
they open ("Apple could not verify…"). Allow the app under **System Settings → Privacy & Security → Open Anyway**,
or remove the quarantine flag yourself:

```sh
xattr -dr com.apple.quarantine "/Applications/Flightdeck.app"
xattr -dr com.apple.quarantine "/Applications/GameDev Studio.app"
xattr -dr com.apple.quarantine "/Applications/Dev Studio.app"
```

Only do this if you trust the download: it skips the check macOS would otherwise make.
