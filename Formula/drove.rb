class Drove < Formula
  desc "Versioned, declarative agent workspaces"
  homepage "https://github.com/radiator-engineering/Drove"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.0/drove-aarch64-apple-darwin.tar.xz"
      sha256 "d60f2a48a14d3645d581b8db8f721e054c6201ce78f2807fb4b1c1ecd2bd6db3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.0/drove-x86_64-apple-darwin.tar.xz"
      sha256 "87e823ab64605abce3ea3f0487348a6f82090fd92875d75cff6b2834349cec17"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.0/drove-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a64022f6c89df19474b0064a927a20a40ffe2e71a4a405d56bb01fbc9256b6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/Drove/releases/download/v0.1.0/drove-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dfc78b7b9f8abd18219a647ea4281081b93b91c7562c5e58a290635bf4c01541"
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
