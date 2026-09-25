class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.34.0/gander-darwin-arm64"
      sha256 "b5728a4c3da85fd52ada88f06c4949fec8936193eea75d61654485424ce32dc6"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.34.0/gander-darwin-amd64"
      sha256 "02d4176e3c25342834622f929110481fae0c0c6ac9599771215cbb5501668df2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.34.0/gander-linux-arm64"
      sha256 "3e065e27d9c25b6e98590c0dc5aeaaf0e692c59f3174373b09b564e59c748680"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.34.0/gander-linux-amd64"
      sha256 "444edfc9ff49e8926b85d583cdac577e33110030609bea0d1a94c02657fb4133"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.34.0/gander-man.tar.gz"
    sha256 "14177bfbd0bef773a48f21f2f0602b16e154aacbbf368d2dae6bc27d0a148c56"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.34.0/gander-completions.tar.gz"
    sha256 "cf10852d2f0dfb64e2ca39384cdc806219911a05466455ae66e24e7c44af0646"
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