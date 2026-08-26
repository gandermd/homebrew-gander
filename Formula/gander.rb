class Gander < Formula
  desc "Render Markdown locally, optionally share it on gander.md"
  homepage "https://github.com/gandermd/gander-cli"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.15.0/gander-darwin-arm64"
      sha256 "0f1a5ce0022e90cb5dbc8789629469a9459f95b2fe37273bedc1867e9f57c1cc"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.15.0/gander-darwin-amd64"
      sha256 "025082893c0e252bb427d1ec3c4718180dab377eacf55dc163deb19b5b29ac35"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gandermd/gander-cli/releases/download/v0.15.0/gander-linux-arm64"
      sha256 "62a094d5818643b907db228d6b8d0cf40834358096106f1e45c78f7063ddca46"
    else
      url "https://github.com/gandermd/gander-cli/releases/download/v0.15.0/gander-linux-amd64"
      sha256 "ba61f7073e811cc7e3b3f4474dfc556277a9048b72b472e58fa280e46e27f54a"
    end
  end

  resource "man" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.15.0/gander-man.tar.gz"
    sha256 "b1dd06c839d62ca6227871eabb58eeb6f1048f497eb134f473eb8de7d10bbcf1"
  end

  resource "completions" do
    url "https://github.com/gandermd/gander-cli/releases/download/v0.15.0/gander-completions.tar.gz"
    sha256 "db3f569670387b78e750780aecd473b981c2a3783dd71356a23de054538c5d46"
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