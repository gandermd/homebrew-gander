class Gander < Formula
  desc "Live review loop for markdown an agent is still writing"
  homepage "https://gander.md"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.35.0/gander-darwin-arm64"
      sha256 "ab9d16346a85fb9e9791496199710dcbb9241f0167be0ecac23513699e98081c"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.35.0/gander-darwin-amd64"
      sha256 "42424a4056bf9e99f37ea6f0e14852093e79aff6bf9b9390737afddbc8e62fdd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.35.0/gander-linux-arm64"
      sha256 "12f483979da826ca5cf37c7d23137e0cba9e86fff500f3596431821b1de3b54f"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.35.0/gander-linux-amd64"
      sha256 "79b2f5086d1a87673d06d820d0ece6d0c8372991e8101ed63a23aa2e29442844"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.35.0/gander-man.tar.gz"
    sha256 "9e914445286b4d978d500421feaef51e229758cd1bba318a75ca70ec5d9d55c0"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.35.0/gander-completions.tar.gz"
    sha256 "f1afd9270e1ec380a1af1363a22942a0b0fb9896f44a10a3899b6c8bf4845adf"
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