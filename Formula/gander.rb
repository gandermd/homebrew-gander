class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.16.0/gander-darwin-arm64"
      sha256 "af5aca5a5d6b7890dcc512202c448eefceef5c5748a9229afcbfa5db283e9ada"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.16.0/gander-darwin-amd64"
      sha256 "86de81c5f4b86c8c1843667eca427299e3817b0ff8eabe77baa15d2d608dfc6a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.16.0/gander-linux-arm64"
      sha256 "2543bf68d10e7be20993ed911aa8248ae1a857fb65dd5aad75b3a731de81cdfd"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.16.0/gander-linux-amd64"
      sha256 "856a698c0f9d27d823dc64d0e33a96d01bd4fbc0c28f5899debf62374137daa9"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.16.0/gander-man.tar.gz"
    sha256 "74f78adfdea055ecedeb7351ec8ee7af1f3d99975aec394b4f4d113c6255efbb"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.16.0/gander-completions.tar.gz"
    sha256 "29a4271da38d8a04aaf716f4dcf07636a3d70bad271d5af961faa1353d17aa89"
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