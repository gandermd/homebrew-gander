class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.30.0/gander-darwin-arm64"
      sha256 "3df38f453b7b16187e9dc05ef2abd5e59ae5ee18e3c723e54e8bd8eed972dd69"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.30.0/gander-darwin-amd64"
      sha256 "796acd1deabb101665328f4c0aeed9ccdb6282c71ef4febaa37c54d8fe4df28b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.30.0/gander-linux-arm64"
      sha256 "7e1a5036f77e7a019fea17eab3d440f2d6ca0ad978e165e8aa192ae7a1dbd693"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.30.0/gander-linux-amd64"
      sha256 "be61605819e9dec1d160dd65c71c997b7efc6f259184280e9639b8f5826f2896"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.30.0/gander-man.tar.gz"
    sha256 "e8758514e38048ca09896f756b68200f1bb0317ac7990863689fdd38ff2cd12f"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.30.0/gander-completions.tar.gz"
    sha256 "19e8181a27044da4b70b4572fe63d35500e85ecd76321541fdbb496f6c7f3e82"
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