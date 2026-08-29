class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.0/gander-darwin-arm64"
      sha256 "1a035dff02b601420016810888ab3ff07474531fe545c19ba733b31c730546f0"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.0/gander-darwin-amd64"
      sha256 "5195123a1c42bae4245d7643022144d55fa05951d3277fc693b66ca3054e71c1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.0/gander-linux-arm64"
      sha256 "f263969aa2e5daf60c3171ab8ce76f57afeb2f263b6be64b04116fbed6cace51"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.0/gander-linux-amd64"
      sha256 "fa2f06214d04055b643454a18e7cb334edbec7331b4eec4581d9fd0c43e5b4ed"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.19.0/gander-man.tar.gz"
    sha256 "2516190cb9669b6d2f4ad67fcfb21f1974f5cd497d1d287f0e9cb4b1cf17f52b"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.19.0/gander-completions.tar.gz"
    sha256 "ab6c56670296d8b807d8b16719c0d8a956cf2baaea598ad49e2645fe69142269"
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