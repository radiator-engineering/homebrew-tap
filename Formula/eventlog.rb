class Eventlog < Formula
  desc "Append-only JSONL coordination log for multi-agent repos: one controller writes, reactors act on events"
  homepage "https://github.com/radiator-engineering/eventlog"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.5.0/eventlog-cli-aarch64-apple-darwin.tar.xz"
      sha256 "458ae45e33b6f740243694d18a056e414946bd0a35e5a9cf1b7ae12f4397a0cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.5.0/eventlog-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9a84cfa446322bcd5cf7fb5d81b1f71f6099b8dec74a2c643105adc4152df75b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.5.0/eventlog-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5f206838caac0a8c30f6158e77b5e9da2e5ff62f1becdb780ec6f7492c97b88f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.5.0/eventlog-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "476ee961a606703dc5c400ec7a7d16b5ca8b20945a0d2445a1b7250c4c14f0a7"
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
