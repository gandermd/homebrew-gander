class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.27.0/gander-darwin-arm64"
      sha256 "607d600ce7bd93b16b2e0cba8aa665f1853e53d1fe0829b3dc15ab8bbc253401"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.27.0/gander-darwin-amd64"
      sha256 "18b8607c7ecd5fb12e3db1a2bf684762cc5cb24e55d5ec531e0bb965ffd9909a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.27.0/gander-linux-arm64"
      sha256 "37ea28a52eb8df217488ab8ff54721aee00a988fe40d314cad3978d2924783b6"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.27.0/gander-linux-amd64"
      sha256 "4a5514b4109dc2f0dc4e9654a3c6239a1cb163ff5e35f531e0094743db9af519"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.27.0/gander-man.tar.gz"
    sha256 "b8795fa3dfab3741bccc29d144248d49f2dbdf86c777bcd80b7b91ec62bf8f9a"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.27.0/gander-completions.tar.gz"
    sha256 "d7ee8b4a841914230495a07775e0a8da719fc8c74cfe2e37144e01c45661ed3e"
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