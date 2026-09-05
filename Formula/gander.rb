class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.24.0/gander-darwin-arm64"
      sha256 "22f6a423609c18dd92408719649559154aa0d85e957307d4c9bfc5cea987802a"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.24.0/gander-darwin-amd64"
      sha256 "ed64f01075ec93b2889040e9b4766a9bc832abdf22ca357577f0802a9f42c857"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.24.0/gander-linux-arm64"
      sha256 "2790ea73c545d335f93687631fcca439d8a50f98dc68a5447ee19e9d7ed3ebea"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.24.0/gander-linux-amd64"
      sha256 "430523bea22fc21be9982e9bbb1e916dc1d65f19b7812852f5bfead301cc73c4"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.24.0/gander-man.tar.gz"
    sha256 "f2364272672233ebdfa49150b7e1c28ee5abfcbb54d409f97931945ae5d42a5e"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.24.0/gander-completions.tar.gz"
    sha256 "dac836c028a0909becdba1026de35c53d80ed3dbbaa5f85bb1ce7b08b0ce90bb"
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