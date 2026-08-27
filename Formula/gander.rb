class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.16.1/gander-darwin-arm64"
      sha256 "6979a808e4276c406788c2a3ede3f19fb581900dad2ebd2002ce5d08758dc23b"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.16.1/gander-darwin-amd64"
      sha256 "3287bb2322e62869ebde44d20ed85cb3ec8d8e6c42a09680bd4f0b5eb2123b75"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.16.1/gander-linux-arm64"
      sha256 "0e1403f96e5739791b34e856db8ca6eae8a88737c35831c127d46d8d0247c13c"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.16.1/gander-linux-amd64"
      sha256 "168a6d310e96e0151d6e0904bc6eff573994320eccc533da843185b53759660d"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.16.1/gander-man.tar.gz"
    sha256 "d1da1f672e1c4602820e2feb14b8b9cdaa4653db5a4fa9f3c15ef7077f948576"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.16.1/gander-completions.tar.gz"
    sha256 "5fe6a0a92dd423a7d1f2b860a839100f51b37e3ded64f29f0b7431b9fc48ddb9"
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