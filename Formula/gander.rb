class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.31.0/gander-darwin-arm64"
      sha256 "96df621fc7933c44261e5e4875f0337cc244428c0a55e84c846039874238c5ca"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.31.0/gander-darwin-amd64"
      sha256 "0ca702119af864679218d75e3e5727f45e2e3a34878238f454097be6ee0ab668"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.31.0/gander-linux-arm64"
      sha256 "4425f1c7851bd7830db156c31122d918c60410c0f7afa596f5ac19fd27f90b28"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.31.0/gander-linux-amd64"
      sha256 "db21cdd770cae93894e76991fd16978d11abcd41cc653372bd62bfebc5784428"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.31.0/gander-man.tar.gz"
    sha256 "488048ddd336e102cb70956b581522a3e33913bef91fd7582a416ad3796681f1"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.31.0/gander-completions.tar.gz"
    sha256 "c74f31c2da0fd64bedb231d2a434cda1b662ef3771c4d45baa86384064b3d540"
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