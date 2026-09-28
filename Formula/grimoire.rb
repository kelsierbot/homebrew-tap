class Grimoire < Formula
  desc "A terminal writing desk for novels"
  homepage "https://grimoiretui.com"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.0/grimoire-tui-aarch64-apple-darwin.tar.xz"
      sha256 "687142d97c4f53dc51d56250fee9f45a9a2729fae94a62104cb7c852ab69f1df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.0/grimoire-tui-x86_64-apple-darwin.tar.xz"
      sha256 "3766eace9c763e244fc7a08f1c84024db40cf3b32c338b05a2daf329b5f8619b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.0/grimoire-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "55ca28c36747c67e933a4b09cb4307f0750aee6aed9daa58ed1b2d92f9ea0047"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.7.0/grimoire-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ce21a6429d02fa4a863ff7d935cd05d140de4c1a9faca7d41bffef3090e17209"
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
