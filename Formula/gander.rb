class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.22.0/gander-darwin-arm64"
      sha256 "199bdbe532df8307e806198cb0e72ea360b9647e7f19643b71ba3592dfe06c74"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.22.0/gander-darwin-amd64"
      sha256 "7f904d0aad948fbb61d6a7216173d09bf5bcb8ea73c564b04203680955eb0841"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.22.0/gander-linux-arm64"
      sha256 "f10a639f90c9531971bb312411f89d770355a99de922326c418badd26faa6eec"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.22.0/gander-linux-amd64"
      sha256 "41c4c4222a57c56b7cd971139bbb73cab44c3171c4d154344d44373531565d75"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.22.0/gander-man.tar.gz"
    sha256 "75d7b2e31f36be743bc3ce070074a6a62ef69acad13859c9581c0e67434056b1"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.22.0/gander-completions.tar.gz"
    sha256 "c4e71331f2ef0c6ec8d08e574a10424523fccf8cd1041dca4e5ebe007b1a900c"
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