class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.37.0/gander-darwin-arm64"
      sha256 "bfc41437b0ea73b81bf171e7f397afdfb1dd57ad4c4aed0e48ae78428ba2878a"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.37.0/gander-darwin-amd64"
      sha256 "2fa2beb109dc73e7649b220a2bdb6480dc937225650fd586feba2d1f39e1671b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.37.0/gander-linux-arm64"
      sha256 "ff9b45916c47d137f4ac5f9dd9c6bf5f86c9eb34db990b5813cbc77c868faacd"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.37.0/gander-linux-amd64"
      sha256 "f4e55861bb32f8e84b7522eb1dd8df428fa62b0f45bd2f1565752a15977954ab"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.37.0/gander-man.tar.gz"
    sha256 "6615faa284fbc8cd61f9283647a17a4aa567c3f24eb7cfa46584b468843248b5"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.37.0/gander-completions.tar.gz"
    sha256 "fabf1869ef5f028ad4f09cfb94924545be16aba7213bc8407501e72694ab9503"
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