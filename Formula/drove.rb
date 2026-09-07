class Drove < Formula
  desc "Versioned, declarative agent workspaces"
  homepage "https://github.com/radiator-engineering/Drove"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.3/drove-aarch64-apple-darwin.tar.xz"
      sha256 "e5adf24b93b6f12b75bf1a6758bf756fa934662280f23dac0b8450d1a12c9ce0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.3/drove-x86_64-apple-darwin.tar.xz"
      sha256 "5b035db2941c954658f5879f428ba56aa834420d612867031ebf1db7356638a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.3/drove-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d70901e26d9e75b01e3d101eecd48f6da2ea5de5e056f2eaf5240a18a6167bc3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.3/drove-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a9eef81e23e739412d0f39aa4689d6c0a4dfbc5ec30d8f116082dcf99db9903"
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
