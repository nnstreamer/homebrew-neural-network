class Nnstreamer < Formula
  desc "Neural Network (NN) Streamer, Stream Processing Paradigm for Neural Network Apps/Devices."
  homepage "https://github.com/nnsuite/nnstreamer"
  url "https://github.com/nnsuite/nnstreamer/archive/v0.3.0.tar.gz"
  version "0.3.0"
  sha256 "d56e4baa4830b544b823357f927262ac14cac5bd3363c8e428c7ed4922d7209a"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "googletest" => :build
  depends_on "libffi"
  depends_on "glib"
  depends_on "gstreamer"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-good"
  depends_on "numpy"

  def install
    system "rm", "-rf", "build"
    system "meson", "build", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "-Denable-tensorflow=false", "-Denable-tensorflow-lite=false", "-Denable-pytorch=false", "-Denable-caffe2=false"
    system "ninja", "-C", "build", "install"
  end

end
