class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.25.0/gander-darwin-arm64"
      sha256 "16fbdbe121b96d5ca0d79b4f2b253264a14d8d545504bfe42ab6e973999f093b"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.25.0/gander-darwin-amd64"
      sha256 "6db4a38c9189d3d195db6860fef14bc7dba2cdd01f468c49cb998c3d714fb27a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.25.0/gander-linux-arm64"
      sha256 "be6cc855ea961f7cc884556fdfc68003496def06007471386a6a3d8a12dad3a4"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.25.0/gander-linux-amd64"
      sha256 "5f66fbab438e7599abed958a530fc670e89860fac73f2cc2580a2e02c48c5bac"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.25.0/gander-man.tar.gz"
    sha256 "12d16e8cd493b0fe5bdb28b2ed13a2192080cea7341eb52246cf85abd1c7e6da"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.25.0/gander-completions.tar.gz"
    sha256 "dadb2bf42a77497d98d771c55026984181e72c8afb627b2611fc4e3a935c6891"
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