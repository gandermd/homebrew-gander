class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.14.0/gander-darwin-arm64"
      sha256 "d696fd3b5fd038b3ff060836a162095272701b300bd86feadeeb546d6d50c429"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.14.0/gander-darwin-amd64"
      sha256 "a6f74d20a0af5b1fa3456ae2e00f090fcc6e732b54aebc7233caf586cdfc3c29"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.14.0/gander-linux-arm64"
      sha256 "37d407d4b83b7fa9845bdf215e5c909cd48b12148f6e401bf7d30af113d188b4"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.14.0/gander-linux-amd64"
      sha256 "088af199d1f817faaddf70d9cb1dd838df807129683785feff14073399eea2b5"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.14.0/gander-man.tar.gz"
    sha256 "69fea3486e69b2afe6aadd8367d23c224be75c3852da6515ee5e994f08025f5f"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.14.0/gander-completions.tar.gz"
    sha256 "b60a53e18d260ec70688c2c31ac67c7ddf8dc8ad8ba7544905645d13d0fa0fd0"
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