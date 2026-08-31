class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.21.1/gander-darwin-arm64"
      sha256 "d355c4a45214b9d95ea17642b7c5d14c260066f168fd4b098edd9aa3d68ca80d"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.21.1/gander-darwin-amd64"
      sha256 "4e90f97d94d38e2a89a4bbebb8afe641940762a60e442f222069391aff01636e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.21.1/gander-linux-arm64"
      sha256 "c0e4ab8d2262fb14caba797715df28a8d1596ce99321c33525d1b714893db8c1"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.21.1/gander-linux-amd64"
      sha256 "da12f9a06168e60cae7df6f72845933d96bf4e18f24e21dd789d56e865a476c6"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.21.1/gander-man.tar.gz"
    sha256 "510ee22d0bd9b9a78569f081f081549693b37884a1c6ecf83f57615e6088efed"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.21.1/gander-completions.tar.gz"
    sha256 "4a63fbd78d767865d83fde8396840db477090262588f7e92bb8f02640fc4c0d8"
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