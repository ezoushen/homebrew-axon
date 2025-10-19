# AXON Homebrew Formula
#
# To use this formula:
# 1. Create a tap: brew tap ezoushen/axon
# 2. Install: brew install axon
#
# Or install directly:
# brew install https://raw.githubusercontent.com/ezoushen/axon/main/homebrew/axon.rb

class Axon < Formula
  desc "Zero-downtime deployment orchestration for Docker + nginx"
  homepage "https://github.com/ezoushen/axon"
  url "https://github.com/ezoushen/axon/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "20481a3f1eb58ade737a27594929695c4c0aa36b88516eba657ee8887558dc09"  # Generate with: shasum -a 256 v0.1.0.tar.gz
  license "ISC"
  version "0.1.4"

  # Runtime requirements (not installed by Homebrew)
  # These are checked by `axon setup local` command
  # Users should install: yq, awscli, docker, node, npm, decomposerize

  def install
    # Install all files to libexec
    libexec.install Dir["*"]

    # Make main script executable
    chmod 0755, libexec/"axon"

    # Create symlink in bin
    bin.install_symlink libexec/"axon"

    # Install shell completion (optional, if you add it later)
    # bash_completion.install "completions/axon.bash" => "axon"
    # zsh_completion.install "completions/_axon" => "_axon"
  end

  def caveats
    <<~EOS
      AXON has been installed!

      Next steps:
        1. Verify installation: axon --version
        2. Check required tools: axon setup local
        3. Install missing tools (if any):
             brew install yq awscli docker node
             npm install -g decomposerize
        4. Initialize config: axon init-config --interactive

      The `axon setup local` command will check for all required tools.

      Documentation: https://github.com/ezoushen/axon
    EOS
  end

  test do
    assert_match "AXON version", shell_output("#{bin}/axon --version")
  end
end
