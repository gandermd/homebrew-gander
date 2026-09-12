class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.28.0/gander-darwin-arm64"
      sha256 "250e0738189b16fdc0fafe99080ce66e9fd36b798485c4d558b12f528a67a88a"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.28.0/gander-darwin-amd64"
      sha256 "e9ddc71db6f0d8985575edc85b9dbdb38b206f6dd14c0a1f1bf8d61b1d15ad17"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.28.0/gander-linux-arm64"
      sha256 "497aed42980ef582ce20a16b0e8ec86596fc2a5eb8b2166eb97592755b177c35"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.28.0/gander-linux-amd64"
      sha256 "e53d4f5d026ee87d8c7bdc788dbb93dbc8f25a821c88c5079473c11398c86a5c"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.28.0/gander-man.tar.gz"
    sha256 "9e7b2ab2f492e73c86d1cd0385e095862921bddab5bd3d5197b360c041cf47be"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.28.0/gander-completions.tar.gz"
    sha256 "415ed79b7a1ac40d1d23265c1284f016f3b5ee73d2c7b00470b58b45c29d1ce6"
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