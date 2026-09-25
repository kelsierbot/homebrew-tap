class Grimoire < Formula
  desc "A terminal writing desk for novels"
  homepage "https://grimoire.joshking.ai"
  version "0.5.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.5.4/grimoire-tui-aarch64-apple-darwin.tar.xz"
      sha256 "c9d805ae0a0d7e5fe6b99ca29d8c739a54ed3c64c9bdacc7a38bbafba30b8254"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.5.4/grimoire-tui-x86_64-apple-darwin.tar.xz"
      sha256 "5f2e89010a8c33e0d136275f15a4706e34cd310ee563095d63e332712d774387"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.5.4/grimoire-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fa1c76eda8abe5b94601fe5fb27c7cfc5e8d631eb94d8a7bb58bcb3e9fb724e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.5.4/grimoire-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f70da78bcfe34790cf68c5509d3f2c4c79365e725c709c12faca5b65cfab4bf0"
    end
  end
  license "MIT"

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
      bin.install "grimoire"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "grimoire"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "grimoire"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "grimoire"
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
