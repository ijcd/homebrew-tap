class DevIp < Formula
  desc "Static per-workspace loopback IP + hostname allocator for macOS"
  homepage "https://github.com/ijcd/dev-ip"
  url "https://github.com/ijcd/dev-ip/archive/v0.1.1.tar.gz"
  sha256 "e6c78fdc468135e8fe12c030c3f69fdbc2b18cc71a47f7dbc39ecd1e99781a42"
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
