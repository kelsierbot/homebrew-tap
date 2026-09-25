class Grimoire < Formula
  desc "A terminal writing desk for novels"
  homepage "https://grimoire.joshking.ai"
  version "0.3.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.3.5/grimoire-tui-aarch64-apple-darwin.tar.xz"
      sha256 "c145c727c1c5d18ca536e92d164e8a45d07b7f0ffcd4e0f25fe43b2d244f3c43"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.3.5/grimoire-tui-x86_64-apple-darwin.tar.xz"
      sha256 "e74697d81208ab4b22fe4981d1b4f39db397ac3b8bbe798807bd107c0f18bbd2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.3.5/grimoire-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "afff187963e26be5c8355e6601483bbcdf4e2e40ae009f22ab1c010467c96196"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kelsierbot/GrimoireTUI/releases/download/v0.3.5/grimoire-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f35d4707e016b45d7b3af3f8ee09d00d7e8ecb5c31528c107db75437a5201076"
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
