class Drove < Formula
  desc "Versioned, declarative agent workspaces"
  homepage "https://github.com/radiator-engineering/Drove"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.2/drove-aarch64-apple-darwin.tar.xz"
      sha256 "2e054fade943a9502ae1d1fac20019ca73cf5a125c8095d8f1e308f79f606b3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.2/drove-x86_64-apple-darwin.tar.xz"
      sha256 "eb8164e13bfcc82064bfe99b476625a9f6d82c91776941048a97ea61935dfe50"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.2/drove-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8968afba6148926eeedc4c22be8221955590ea827691ebe2faf44d1ed7a59b7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.2/drove-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bbb0d4de3d9e243bea2c9207e83ed811085292563c5fd4dec09138c49f1f4b3e"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "drove"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "drove"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "drove"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "drove"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
