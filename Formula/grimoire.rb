class Grimoire < Formula
  desc "A terminal writing desk for novels"
  homepage "https://grimoire.joshking.ai"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.4.5/grimoire-tui-aarch64-apple-darwin.tar.xz"
      sha256 "6e618060f3daa74a372ce843bb2559eae4affa894d55e45a12141421f6757a47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.4.5/grimoire-tui-x86_64-apple-darwin.tar.xz"
      sha256 "68251f06b485e8febd6372beef611f10fa6c1137ace4ed20903cfbaece0e899e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.4.5/grimoire-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "36abb3f4848c1fdfe3cac9b603b8f253d2e13154cafcb81d3716a056fd23ff99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.4.5/grimoire-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1626b39aad06cefb3f3d1606b3517760efa56a71977742966e5f9bb5e997837d"
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
