class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.32.0/gander-darwin-arm64"
      sha256 "dc91c73cf00eee01af9d91b9c303a53d8a3025c203ae793475ef61d67a28bd5c"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.32.0/gander-darwin-amd64"
      sha256 "938db1a1bbbdd2751bfbb07bf02b83839e6e7790f347aedfd3c9784eb9900990"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.32.0/gander-linux-arm64"
      sha256 "9d7d8211f99c6e20d28656d8a21df1dbeabdd1b35f7b4819d9cc100b23023097"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.32.0/gander-linux-amd64"
      sha256 "2531a26cbf300bf7f92098b0e1ec07729bca43d62356625394849a63e95d6e3f"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.32.0/gander-man.tar.gz"
    sha256 "f7bb42c6abade2c154f806b34945327f14819b42a16ef30480ed8baf8d724462"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.32.0/gander-completions.tar.gz"
    sha256 "7c57466721ded80a0166918af74b836f79cfcd79c5d0ed8c0aaed48b4525bc35"
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