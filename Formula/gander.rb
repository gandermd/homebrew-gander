class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.1/gander-darwin-arm64"
      sha256 "3eecca2d72a830289a8921f7812dd2750a78353bcb362a9f6c694d0a400f2940"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.1/gander-darwin-amd64"
      sha256 "b22bd47eb10075fe1858c153d1a0801f8e50e2a1f95bbbe2e98267f7b7599236"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.1/gander-linux-arm64"
      sha256 "6dc29dea5d813f1b3eb7a0bef36568ecf5b7bd3012c24c2bc631cc85f2788c07"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.1/gander-linux-amd64"
      sha256 "ee6d70c00deb1e4e5053354628e4a2289adc49c939cddebd21d5538fee7b1f41"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.20.1/gander-man.tar.gz"
    sha256 "dc2b79156f9ae8f3e040a2010f1eb7dffaa1435693a16150b8286e7820362ede"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.20.1/gander-completions.tar.gz"
    sha256 "133335218dfbcf8c4c6216d9d59a87753735f00857cc79f18775640f20c5ba69"
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