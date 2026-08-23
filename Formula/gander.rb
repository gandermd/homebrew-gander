class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"
  version "0.11.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v#{version}/gander-darwin-arm64"
      sha256 "70092f19d2841ed2ef1057dbbd178786fd4b795269f7316fec5d69bc026c6198"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v#{version}/gander-darwin-amd64"
      sha256 "11380f512cfc61f09c21e81ad5a0c6bf3138e044aae9351750dd76785f906128"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v#{version}/gander-linux-arm64"
      sha256 "6aa464504e1991529a132e692540fd65071e59c5655e63bd7c00a5c9e9ecc60c"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v#{version}/gander-linux-amd64"
      sha256 "62a19896c1937885c468013f2ef0dd470fa357120dd4d1ce062208bc6309062a"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v#{version}/gander-man.tar.gz"
    sha256 "5996bb2ff1ff85d13a814e974f9ba33387693122b4e48b4b1d378ff8fdb05af5"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v#{version}/gander-completions.tar.gz"
    sha256 "f686f2660d67cfbb582e9d5e2f9d08cb636b1d6bda178de2dd4744a955d0dc24"
  end

  def install
    bin.install Dir["gander-*"].first => "gander"

    resource("man").stage do
      man1.install "man1/gander.1"
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