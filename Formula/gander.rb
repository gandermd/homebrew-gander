class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.2/gander-darwin-arm64"
      sha256 "3618514a47cf659417c54dfd3282bb4111e6de00dd5a77a510f0acc0cf3f0770"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.2/gander-darwin-amd64"
      sha256 "a9265ed6f58d0511381069f3c4e053a37eb5540516ee6e444aca2fc210a48b3b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.2/gander-linux-arm64"
      sha256 "96ec9810888404df0415a58e9361d58efd5ceba4b872c2dc3f1ba5c67b4a6cb4"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.19.2/gander-linux-amd64"
      sha256 "b850a9242d7555568b2ee6802c98fefdde1a7e393e499d10bec3436133d032ef"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.19.2/gander-man.tar.gz"
    sha256 "d416c9bbf833091418381315459ab2fdd1a107ec5abc848dbcad71b59d509e52"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.19.2/gander-completions.tar.gz"
    sha256 "18093ec76cd00dbb1d612bbf3914d82dd5bc694589e386d8937c5e7c8208a9d4"
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