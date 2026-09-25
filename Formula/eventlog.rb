class Eventlog < Formula
  desc "Append-only JSONL coordination log for multi-agent repos: one controller writes, reactors act on events"
  homepage "https://github.com/radiator-engineering/eventlog"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.3.0/eventlog-cli-aarch64-apple-darwin.tar.xz"
      sha256 "eb27731256d5003376925d0146179aee532a879ce923b587bcd1818efa750d4d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.3.0/eventlog-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ebe4df8c0753f7ee5b02125c1b2df32204a15db870502958c00ebf8145576d5f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.3.0/eventlog-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a8c40cc3abf0ead43da66d5f3076285485178aeeb9747f4d490bdc309a9c4ca6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.3.0/eventlog-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c9cf5a9b4a3a52c6b210d03c7e4e92352a402c3ab539e737496b47f27d21b54e"
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
