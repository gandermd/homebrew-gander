class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.23.0/gander-darwin-arm64"
      sha256 "21312c853c1ed520a2990001228d53f8aaef64d57ee67b2340be0016a4526f53"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.23.0/gander-darwin-amd64"
      sha256 "378fdcc6492c75fb4616d3af549e87f111cbb0f53afa513138742e2f0e234221"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.23.0/gander-linux-arm64"
      sha256 "e548f5aaf195e58d0211c161d33901f84a5ed3ad31175a5208728dc616dfc05b"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.23.0/gander-linux-amd64"
      sha256 "1a2daebec367aae675c0004b8ce7ff082cc1871ec9937a33b2ba36efd5f60611"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.23.0/gander-man.tar.gz"
    sha256 "ae29e2953fade2b4e0e2ee7448dd53e4321e48dcbc6c135a46b6dd713a8fdb3f"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.23.0/gander-completions.tar.gz"
    sha256 "f5eeae755f214a6c6dbc1a7b8ac961b1d4013f87f5abac226c77af7e5111720e"
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