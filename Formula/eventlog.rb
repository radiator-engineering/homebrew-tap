class Eventlog < Formula
  desc "Append-only JSONL coordination log for multi-agent repos: one controller writes, every agent reads"
  homepage "https://github.com/radiator-engineering/eventlog"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v1.0.0/eventlog-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5ffe442e9af07e28d24a511cd735cfea6e1d7b34d3e75442c688934260615ef7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v1.0.0/eventlog-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2b5aa8da0395367fd9b8e77ed5e4426b31b2f62603745f8ac2a0bbe6d7b8bfa3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v1.0.0/eventlog-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0209183b83c9c2651b4e981a08921148859c93d5213dfaad48c4a7d2d53536ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v1.0.0/eventlog-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e131b6335785bf846c35efa7f01d5afb7016f7d1e8f4a409f8288592dc7f8145"
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
