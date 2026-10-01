class Eventlog < Formula
  desc "Append-only JSONL coordination log for multi-agent repos: one controller writes, reactors act on events"
  homepage "https://github.com/radiator-engineering/eventlog"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.5.1/eventlog-cli-aarch64-apple-darwin.tar.xz"
      sha256 "0da139128e25887e290e79f266f3ec39267a02e6a6558c5463a20e00db7a62e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.5.1/eventlog-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1138e4eac76f58850c61a4c3848b8b3b63e199ffab03999bd78a1dd8ef8ab417"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.5.1/eventlog-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9452674d871bfd6b8d990ecd9e920a4c9e5c950494647fa8bd5b86085bdaa767"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.5.1/eventlog-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b72caf2ce67e48d7aebb4d0f16ef02a862e3bf2bcc390189720c147570934b48"
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
      bin.install "eventlog"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "eventlog"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "eventlog"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "eventlog"
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
