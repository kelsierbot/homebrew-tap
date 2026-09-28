class Grimoire < Formula
  desc "A terminal writing desk for novels"
  homepage "https://grimoiretui.com"
  version "0.7.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.3/grimoire-tui-aarch64-apple-darwin.tar.xz"
      sha256 "500e6e7d9c17747e7e8f6fbf22b07d7300f116357eb9725407139f76306c6793"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.3/grimoire-tui-x86_64-apple-darwin.tar.xz"
      sha256 "ab9477e80a9edae5575b438f2a962dbd7a63b9b5c8f05b1ef91eb38a667b395c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.3/grimoire-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "156c143181b61db3606e7b6083d386af17c5ebfa83971c9561c587e027702eeb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.3/grimoire-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "67f5f5516d3b7ddfaadc8d6ee82da8ee04e36037e1ba00ce3dd8707bc67f3009"
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
