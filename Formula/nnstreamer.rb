class Nnstreamer < Formula
  desc "Neural Network (NN) Streamer, Stream Processing Paradigm for Neural Network Apps/Devices."
  homepage "https://github.com/nnsuite/nnstreamer"
  url "https://github.com/nnsuite/nnstreamer/archive/v1.0.0.tar.gz"
  version "1.0.0"
  sha256 "dd99ede1ecd23272c23863fe8be3638d0fc5b644382142a49ce2bab42da11529"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "googletest" => :build
  depends_on "protobuf"
  depends_on "libtensorflow"
  depends_on "libffi"
  depends_on "glib"
  depends_on "gstreamer"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-good"
  depends_on "numpy"

  def install
    system "rm", "-rf", "build"
    system "meson", "build", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc", "-Denable-tensorflow-lite=false", "-Denable-pytorch=false", "-Denable-caffe2=false"
    system "ninja", "-C", "build", "install"
  end

end
