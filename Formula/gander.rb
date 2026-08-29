class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.18.0/gander-darwin-arm64"
      sha256 "46497aedfc37a5a51b14a1ca0b78b6c3301a82e9c9718eb4a5e497e492559b96"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.18.0/gander-darwin-amd64"
      sha256 "c804549acee87aaf8fc95fa957af6e59aa7d5918d24b5c6695ca44ef299221a4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.18.0/gander-linux-arm64"
      sha256 "c046bd0c687b672e6b380d3010c7a903aee148bc8b81f02e7658d65ccccb810d"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.18.0/gander-linux-amd64"
      sha256 "020b8c6fb124cd7eccea1fda7b452f3694b857120622370acf436aca5355c285"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.18.0/gander-man.tar.gz"
    sha256 "b8c3c9750d28a3260a7c125461aa0ea588966ebf32575d5dbb1d0cba248c26e7"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.18.0/gander-completions.tar.gz"
    sha256 "6c0ded17be696ca50e86223da43fd88aed92f6156ecdf42226e75e698897204e"
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