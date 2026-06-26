class GitlabMrTrain < Formula
  desc "GitLab MR release train runner for dependent libraries and apps"
  homepage "https://github.com/SabikAbtahee/Gitlab_MR_Train"
  url "https://github.com/SabikAbtahee/Gitlab_MR_Train/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "d95f9af64ffaf5ec695a418be6f54d230ef448ebf32cedf038d4a2f6b8122d9e"
  license "MIT"

  depends_on "node@20"
  depends_on "git"

  def install
    system "npm", "install", "--include=dev", *std_npm_args(prefix: libexec)
    system "npm", "run", "build"
    bin.install_symlink libexec/"bin/gitlab-mr-train"
    bin.install_symlink libexec/"bin/mr-train"
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
