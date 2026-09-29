class Eventlog < Formula
  desc "Append-only JSONL coordination log for multi-agent repos: one controller writes, reactors act on events"
  homepage "https://github.com/radiator-engineering/eventlog"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.4.1/eventlog-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8e5e9d9483e9c73953dbc216ed62a5d107396cac5916a47e266b7a3168ea39f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.4.1/eventlog-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b472d3348a909f4ed064a39df081d3add8e4aab231606420540585f1dcdf6f74"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.4.1/eventlog-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6f7292efe3a0e534549369a1be15a83889dff0bb7028f3804d91b0731375b8f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.4.1/eventlog-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e830ef594486296e6662a0581413a05861327ec25b79273c4f226a3d276a03d1"
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
