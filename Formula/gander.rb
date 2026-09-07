class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.26.0/gander-darwin-arm64"
      sha256 "f044dca00722cf9e25dc35d1d3eac99d64dcc9a7527f2a1adbc04a451090682a"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.26.0/gander-darwin-amd64"
      sha256 "e84823829939dcbdf684fa9336c4f9231020f82cbd47c82de41e2be03858d58b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.26.0/gander-linux-arm64"
      sha256 "2373cfacf944db03374f8e0e6aa84174f4c4d9d8ddf0f2a590d02bb2b7ee94d6"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.26.0/gander-linux-amd64"
      sha256 "ac4335f74d6e97cc497ec8fa828fc369d9358f3fd0bef00d6fdaef755eb41314"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.26.0/gander-man.tar.gz"
    sha256 "13bc8b19a0c96f887853b3a4b311f482fc2612f2f7225ffd2f0a858e2d5a7f2b"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.26.0/gander-completions.tar.gz"
    sha256 "781fb7a449e463590dfab104006542782bbad9952c2bbb868f6a113265003d5e"
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