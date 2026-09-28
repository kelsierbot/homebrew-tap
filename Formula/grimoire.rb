class Grimoire < Formula
  desc "A terminal writing desk for novels"
  homepage "https://grimoiretui.com"
  version "0.7.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.5/grimoire-tui-aarch64-apple-darwin.tar.xz"
      sha256 "99d24d14951cf974317c30aabf21bf1457b05d4b107057d08348ce1e95c80b7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.5/grimoire-tui-x86_64-apple-darwin.tar.xz"
      sha256 "9f8c3840f8a28c3add054fd24fa423a5fa281b2e11239612bae18e62662ab553"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.5/grimoire-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a401b0b01bb83e9908a474280a2ef0683435405537a901be8e503e22ccbcc6eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.5/grimoire-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "95f7bcf9abbf097539d9db6dbf2b333d2f7fe6caaec3389af45130581b750c35"
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
