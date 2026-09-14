class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.29.0/gander-darwin-arm64"
      sha256 "a2dbf289ab9dcb43ca068f24d2d021d216b3556d594dc3ecf350e84a041439cd"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.29.0/gander-darwin-amd64"
      sha256 "3751ec4d56dcd7189d32d51a15a4f3af7278089428e53fa9a853da28b45f805b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.29.0/gander-linux-arm64"
      sha256 "ca103a8cdb623055c9d62be1d092839372d9088e6b76940459cd4fc8673093e1"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.29.0/gander-linux-amd64"
      sha256 "0c75f80bd9485e25c1606153bebcef72fe323b60c238c5b379cfe3560d127b4e"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.29.0/gander-man.tar.gz"
    sha256 "214d32f6079e9c837263e6c5c18e4c934e321d307df7ab44113d608c25daf990"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.29.0/gander-completions.tar.gz"
    sha256 "02c6b26a420ff369925ba24db23dd3cae8570f33497b395b6fa71108d23e572d"
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