class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.12.0/gander-darwin-arm64"
      sha256 "b66195548419dc2683373ef896fb324280d59c3221e186e41853d804363ee346"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.12.0/gander-darwin-amd64"
      sha256 "ee63110ff903bc38797497de2953ed1061da14fe88661e73ad819394498132cf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.12.0/gander-linux-arm64"
      sha256 "042431df2ea862e080e0ed97a19319da2aeb1bc8823034f2a3075b81541cb58d"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.12.0/gander-linux-amd64"
      sha256 "8a1558a1535be0afbcd074228faeee22fa70da63dbaa6135c0ade3f150bf96a7"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.12.0/gander-man.tar.gz"
    sha256 "215863a6f304a0187464e0d1dff79770c522afd05932692250f3d43781a513bd"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.12.0/gander-completions.tar.gz"
    sha256 "e0ca04c0663c4bc18fc5189cbba4aac9020e60779b34e4c659dfef7bb7ceb62f"
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
    assert_match "render Markdown", shell_output("#{bin}/gander --help")
  end
end