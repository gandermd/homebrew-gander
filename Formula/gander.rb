class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.29.1/gander-darwin-arm64"
      sha256 "aa1be37f7eed25f53b8e5d8d1ef1c1f790586a8fac3b072b7837f861813806aa"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.29.1/gander-darwin-amd64"
      sha256 "cf8fa82cd53c9bdc4bf6e8304ffaa0e17574724366741eab397a58bd72d38802"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.29.1/gander-linux-arm64"
      sha256 "064b596e11caf8d02a88a9020e62299495d7b224c53e4ac7d805a30144969c2c"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.29.1/gander-linux-amd64"
      sha256 "122bfecb9fc5b1718c1a3fadfd13eebf6e32a633807becaa7fc75fe1438627bf"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.29.1/gander-man.tar.gz"
    sha256 "a405e3ecd91fab64c2a59310a8dd563030d0a43a94c4bfedb0b4020e4c673656"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.29.1/gander-completions.tar.gz"
    sha256 "2ad0c1f2489bbbb10dc5ea88c28c7cfdf912a71f623ee5c43ce77c244db3a39c"
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