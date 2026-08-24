class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.13.1/gander-darwin-arm64"
      sha256 "b624ca7c1f9b8485e3c4498585b3fff87c0ec580673145efacc43a9d6b35d859"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.13.1/gander-darwin-amd64"
      sha256 "9d8707502f1e8040f7d34678cef731bbae4020002b6a661f9319411da4bca21e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.13.1/gander-linux-arm64"
      sha256 "27203df3a6a10b4a32cdbd1476ce49dd89e1bb5c6fc02b734cd9b054e1c9a1d2"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.13.1/gander-linux-amd64"
      sha256 "8214d226c6ec9c07e391ee0949bd3e3f3c4732527db8b82da33d9fe9dbeed795"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.13.1/gander-man.tar.gz"
    sha256 "884f9122c8d1dc7a841ea6f21be7b69403369c730caaaa26ed9ecfe9551153fd"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.13.1/gander-completions.tar.gz"
    sha256 "2cf4dd6dda49787f4142b3ba51ad928982cadb3e20bcd8e1e429e38831891330"
  end

  def install
    bin.install Dir["gander-*"].first => "gander"

    resource("man").stage do
      man1.install "gander.1"
    end

    resource("completions").stage do
      bash_completion.install "gander.bash"
      zsh_completion.install "_gander"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gander --version")
  end
end