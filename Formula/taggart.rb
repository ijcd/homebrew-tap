class Taggart < Formula
  desc "Command line tool for converting HTML to Taggart"
  homepage "https://github.com/ijcd/taggart"
  url "https://github.com/ijcd/taggart/archive/v0.1.2.tar.gz"
  sha256 "ad1d16ff75a518f671010f8d42909e88d590f26cb742e066622e479b4770a82e"

  depends_on "erlang"
  depends_on "rebar" => :build
  depends_on "elixir" => :build

  def install
    system "mix local.hex --force"
    system "mix local.rebar --force"
    system "mix deps.get"
    system "mix escript.build"

    bin.install "taggart"
  end

  test do
    system "taggart --help"
  end
end
