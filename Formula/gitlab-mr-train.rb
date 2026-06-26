class GitlabMrTrain < Formula
  desc "GitLab MR release train runner for dependent libraries and apps"
  homepage "https://github.com/SabikAbtahee/gitlab-mr-train"
  url "https://github.com/SabikAbtahee/gitlab-mr-train/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "5534f1b395e2b14d77e343d44a717198628ac0e7d7bc206304660db6046f0032"
  license "MIT"

  depends_on "node@20"
  depends_on "git"

  def install
    system "npm", "install", "--include=dev", *std_npm_args(prefix: false)
    system "npm", "run", "build"
    system "npm", "prune", "--omit=dev"
    chmod 0755, "dist/cli.js"
    libexec.install "dist", "node_modules", "package.json"
    bin.install_symlink libexec/"dist/cli.js" => "gitlab-mr-train"
    bin.install_symlink libexec/"dist/cli.js" => "mr-train"
  end

  def caveats
    <<~EOS
      Also install and authenticate glab:
        brew install glab
        glab auth login

      Then run:
        gitlab-mr-train init
    EOS
  end

  test do
    assert_match "gitlab-mr-train", shell_output("#{bin}/gitlab-mr-train help")
  end
end
