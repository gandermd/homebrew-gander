class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.33.0/gander-darwin-arm64"
      sha256 "dcdd923e918ae83751547eff52b37651cdd177852ce2a3007838fc8c77fbce4f"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.33.0/gander-darwin-amd64"
      sha256 "607cfc71a208212cebd29dd0f184ce4c492f6473bd9f55466266589d9e7da4ed"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.33.0/gander-linux-arm64"
      sha256 "fad50814ba7f550715dc3ca074bf900a470ee6f33a272240c29f73d12b3f5c68"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.33.0/gander-linux-amd64"
      sha256 "a6806d8817022f736761536a60d10282ed3d08c2aa404b3745843311664a7614"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.33.0/gander-man.tar.gz"
    sha256 "3dd4b3abd5421c2c46986238bff75f80a2384627438a66c2e767fdd36f80f6b6"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.33.0/gander-completions.tar.gz"
    sha256 "8a631ea699315590cf71884c5576977b525d2fc1abc90918f7e111e8a0bd6875"
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