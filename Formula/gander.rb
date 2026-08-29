class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.17.0/gander-darwin-arm64"
      sha256 "34d5c1fdfe9fa447c940e9ee1e66bb9a9afe610c8f8c95bcf87b51d4526aea78"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.17.0/gander-darwin-amd64"
      sha256 "6390fa95be20ba1d8d0149df8f3dd43446e4c632a2d4bc27315125987d03a84d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.17.0/gander-linux-arm64"
      sha256 "d64781c195b4238cf41c1bedc70dc1d6a081e7f8ce3efff168c7ec5e0b341e9b"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.17.0/gander-linux-amd64"
      sha256 "f95cadccaa9c85ea9a8d5b11043f238eef6e1b3824bf9317dec76db07c2bec20"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.17.0/gander-man.tar.gz"
    sha256 "a5fd9f8318bd619a8ed3cb407a26bb1e097e05884cf2bc3b1c7132915bec5ab4"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.17.0/gander-completions.tar.gz"
    sha256 "314b5dada238d23f1501dd31617407eb1a8bed117651b0f2869999063008c13a"
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