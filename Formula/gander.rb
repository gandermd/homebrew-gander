class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.2/gander-darwin-arm64"
      sha256 "a52ffa52d3eeb57fc3c2276576067d3cc21372fcacae0310b18f81a1bd7ff127"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.2/gander-darwin-amd64"
      sha256 "c2fe08bb556c52adcbf775c1b175482f7b81125d9d339716996311ddb3e9dcef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.2/gander-linux-arm64"
      sha256 "e7c5ca035be6bf3cedec62f61f8800673747c3f67c03795636f10e2e1d7edad2"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.2/gander-linux-amd64"
      sha256 "91b2d0beba28a0ca1e6de288008d39b4b17911d75bc576dd3f8edd6d08bfefe9"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.20.2/gander-man.tar.gz"
    sha256 "2aa5900901fd387751684e9d041745b29c0517accb8d8a46995219be5c6b104c"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.20.2/gander-completions.tar.gz"
    sha256 "d335fd7d1c5ed236c815297d77149882613e0b594bdf28d961f34982fb8c2d9d"
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