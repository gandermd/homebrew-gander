class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.36.0/gander-darwin-arm64"
      sha256 "5ca8b054f953d19f7a9d638f9327fac70190b0e20c94d82b33d4d0c2c8a33e3f"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.36.0/gander-darwin-amd64"
      sha256 "af7846d2269ce5cf987f41e86c1c409ccbbd4a032eb03da31144f1b6301a5989"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.36.0/gander-linux-arm64"
      sha256 "d302664867ddaf849530b1db9f18313ebdf6e2b3948bb2a75bef262afca6ec35"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.36.0/gander-linux-amd64"
      sha256 "61a8edc66db0c5ae5efd54bedac97ddb11cbb8229cf8048e7b309217642a01b0"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.36.0/gander-man.tar.gz"
    sha256 "8aabe81e1acfeb17748c83b9323ddfc12bc995255e8fcc07895ced2948e0dcbf"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.36.0/gander-completions.tar.gz"
    sha256 "0edf4aa7bd8d16d511eb70e6c6e26b2db336ab5c849cc0b169d8856df77ffc09"
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