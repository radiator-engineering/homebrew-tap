class Drove < Formula
  desc "Versioned, declarative agent workspaces"
  homepage "https://github.com/radiator-engineering/Drove"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.1/drove-aarch64-apple-darwin.tar.xz"
      sha256 "2fc9b11e92a8ee9f85c3a8783ba70ddadfd0129d19d21f64c7286367b981baa2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.1/drove-x86_64-apple-darwin.tar.xz"
      sha256 "44bc16f56c1a713516b90f3cbb4fd5d6eeed58aa4f10d334dd9457d529bd6a03"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.1/drove-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c10d5816b9ee49eb25a26eca3c160d19fc29e2af8f8a920b13de389879c00e55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.1/drove-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "31a8e6322fec874f87a115ec7c53ed145c61dec72948703b2b0605e836fb2a35"
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
