class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.0/gander-darwin-arm64"
      sha256 "acafd4de16886f3ab91d5afa4b470f2229c8b09e274cbbc067b658e7c74843e8"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.0/gander-darwin-amd64"
      sha256 "f3397a92abfeb51119cf77455323f5a4bfca0af21065001944cb73f849cdf6fb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.0/gander-linux-arm64"
      sha256 "e49ee8bf67388f4ee966276da22e6a15e941c87f8b11c1c8ed00d5b2a865d248"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.20.0/gander-linux-amd64"
      sha256 "516664d0f6a06f5c16f28ffb7b6dd2fb275b9ceb74cc16a196eb0ce45e818f1a"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.20.0/gander-man.tar.gz"
    sha256 "d67c668d8ef9fa21e91b5d6ef160595ee382c476a3cbf259fc9c8719f8de9d21"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.20.0/gander-completions.tar.gz"
    sha256 "a8e2f6b5ef5b1e5c2f43417c1af4013de35df59fcf1cf7f75f01aa809c835043"
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