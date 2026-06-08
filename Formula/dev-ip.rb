class DevIp < Formula
  desc "Static per-workspace loopback IP + hostname allocator for macOS"
  homepage "https://github.com/ijcd/dev-ip"
  url "https://github.com/ijcd/dev-ip/archive/v0.1.1.tar.gz"
  sha256 "8d90d11c28135046de637a87cd8897ceef0c2b352bf23f6c4a4a90f170789ed6"
  license "GPL-3.0-or-later"

  depends_on :macos
  depends_on "dnsmasq"
  # perl (flock + socket probe) is provided by the system

  def install
    libexec.install "bin", "lib"
    (bin/"dev-ip").write <<~EOS
      #!/bin/bash
      export DEVIP_LIB="#{libexec}/lib/dev-ip-lib.sh"
      exec "#{libexec}/bin/dev-ip" "$@"
    EOS
  end

  test do
    # `ip` allocates without sudo and prints a 127.0.0.x address
    ENV["DEVIP_HOME"] = testpath/"dev-ip"
    assert_match "127.0.0.", shell_output("#{bin}/dev-ip ip smoke")
  end
end
