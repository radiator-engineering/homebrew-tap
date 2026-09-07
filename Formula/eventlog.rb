class Eventlog < Formula
  desc "Append-only JSONL coordination log for multi-agent repos: one controller writes, reactors act on events"
  homepage "https://github.com/radiator-engineering/eventlog"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.2.0/eventlog-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c0ba519945b47b45b4e32b543f8d71ffd868ad567cd9c7d39d01553ab59315dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.2.0/eventlog-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d484b30c1d7290fb839d679fe9a94bc43bac09333df2dab211a113c827c1740f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.2.0/eventlog-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "222962e750beed6b1afd6312c5b357263081c8e76e253f2b738c748cc53b2efb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.2.0/eventlog-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1cd94d47b43c19be047f292c24c67f6548a41c64031660a5969b6bd144ee8265"
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
