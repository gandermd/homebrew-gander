class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.21.0/gander-darwin-arm64"
      sha256 "64e4d04ff54cdfb7d679d9e1de7018673d18340d6c1c93fc6c1c103ef51b0e0b"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.21.0/gander-darwin-amd64"
      sha256 "168e673ae585e9ff240ddf25e57c762df1c454a495a86d8f1a31186e20bd2be0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.21.0/gander-linux-arm64"
      sha256 "5e71dd2b8b46c14ad6c495898cae1fa4efacbdf07203e7674609482db3e2f029"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.21.0/gander-linux-amd64"
      sha256 "24b2c493429a0429d056af452df9ec9ceacca8d5a30af1d42102746fc50caaa9"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.21.0/gander-man.tar.gz"
    sha256 "4d263d13abbcf08f40a3625e56f11ec6d198caa34bb1c67e46e9236a9eeec49f"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.21.0/gander-completions.tar.gz"
    sha256 "31ff4bcdafd6d8c547e5e2a0c8a85e510955198ddda0860575dc4cfebd19708f"
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