class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.1/gander-darwin-arm64"
      sha256 "96d53e70234ce19b6ff386be47feea56badbe36c9047345679e9a03ee31b2e06"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.1/gander-darwin-amd64"
      sha256 "2abe83531d895091091354e24a815219c4d45472404cd5727cfc0b731bd247b3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.1/gander-linux-arm64"
      sha256 "c1319c587972db9a7bbe55df8a916d61779a1d5ddf5261ecb4e818c6c2f4cc36"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.1/gander-linux-amd64"
      sha256 "11cc73102cd96066e711a0921d56199cd283efbddbcc321b16dabb3a379118a7"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.19.1/gander-man.tar.gz"
    sha256 "69efe6ff40faaf00d8735b75c70c4785c8eef72ad771adc584570c303fd0f5dd"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.19.1/gander-completions.tar.gz"
    sha256 "e946fed922367659762102dd17afd43af46491057bd318aef2ac55cd61c21caf"
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