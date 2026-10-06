class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.38.0/gander-darwin-arm64"
      sha256 "ea79e607814e02a82f7ad0cf1cadc4178491cfc65f30c718e0064a5ecc15dd74"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.38.0/gander-darwin-amd64"
      sha256 "2523f79a4217c1ffa6d0bdaa53a8193d751e94cea2a88c75945f457f6304b5a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.38.0/gander-linux-arm64"
      sha256 "c889bb09fe527dd42d86495d4cfd7ff2aeab24731ecf94ace3d499c9f9c36ad9"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.38.0/gander-linux-amd64"
      sha256 "029963d34b1336cb0c1d7ef344e092b660e58ed35ddcf421ac77a9950e29a688"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.38.0/gander-man.tar.gz"
    sha256 "a2d281965749cf4c3eaa5eda6975c10f0aea845d65944ba712bc9a3e18365771"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.38.0/gander-completions.tar.gz"
    sha256 "b0bd4e6156fabb156d9012f3da9b35ef99088845eb80afdefaed0ddd16a2b40b"
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