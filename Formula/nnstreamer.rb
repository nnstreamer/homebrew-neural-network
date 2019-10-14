class Nnstreamer < Formula
  desc "Neural Network (NN) Streamer, Stream Processing Paradigm for Neural Network Apps/Devices."
  homepage "https://github.com/nnsuite/nnstreamer"
  url "https://github.com/nnsuite/nnstreamer/archive/d1b0cf4625c1efa309d696c9c6100b242b63d3d8.tar.gz"
  version "1.0.0"
  sha256 "f6f267a4e643d881bce375dcec6988047cdf2bb301e1b84dbff0eb95024a5115"  

  depends_on :macos
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
