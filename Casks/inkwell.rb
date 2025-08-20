cask "inkwell" do
  version "1.0.1"
  sha256 "1210d481f8c048c602488b60cc8f628b7054da40cbd874a55d78f4219bdbf7d9"

  url "https://github.com/cschuman/inkwell/releases/download/v#{version}/Inkwell-#{version}.dmg"
  name "Inkwell"
  desc "Fast, native markdown viewer for macOS"
  homepage "https://github.com/cschuman/inkwell"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Inkwell.app"

  zap trash: [
    "~/Library/Preferences/com.coreymd.inkwell.plist",
    "~/Library/Saved Application State/com.coreymd.inkwell.savedState",
  ]
end