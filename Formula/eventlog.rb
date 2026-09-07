class Eventlog < Formula
  desc "The eventlog application"
  homepage "https://github.com/radiator-engineering/eventlog"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.1.0/eventlog-aarch64-apple-darwin.tar.xz"
      sha256 "7a6667249ad83bd1065359b8ccf2387e54dede4112449a8408b49b8c8c8327f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.1.0/eventlog-x86_64-apple-darwin.tar.xz"
      sha256 "5c7b3ed9068d30a3aac63afdb00d8c07d02aff757358a7d5a5047645538fade5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.1.0/eventlog-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "84e2779852999d3f19286294a1c15e08ecd996be30805d5978de05bec730efa4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/radiator-engineering/eventlog/releases/download/v0.1.0/eventlog-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7017e70274061aaa0fc5454c4c6426c1eb06bd02da2c1cc46e4dfc1453df8df1"
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
