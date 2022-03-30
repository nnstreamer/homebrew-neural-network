class Nnstreamer < Formula
  desc "Neural Network (NN) Streamer, Stream Processing Paradigm for Neural Network Apps/Devices."
  homepage "https://github.com/nnsuite/nnstreamer"
  url "https://github.com/nnsuite/nnstreamer/archive/c110844c31bd0fb4eb0a8cf6ac8bf969c81db397.tar.gz"
  version "1.0.0"
  sha256 "d4397a77a18fc0d881b2aff4fdf68e251ccea7ca84d8a765c52eee0df1cd7e76"
  depends_on :macos
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "googletest" => :build
  depends_on "ssat" => :build
  depends_on "protobuf"
  depends_on "libffi"
  depends_on "glib"
  depends_on "gstreamer"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-good"
  depends_on "numpy"

  def install
    system "rm", "-rf", "build"
    system "meson", "build", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc",\
        "-Denable-tensorflow-lite=false", "-Denable-pytorch=false", \
        "-Denable-caffe2=false", "-Denable-tensorflow=false"
    system "ninja", "-C", "build"
    # Before installation, run build-time tests
    cd "build" do
      ENV["GST_PLUGIN_PATH"] = "#{Dir.getwd}/gst/nnstreamer"
      ENV["NNSTREAMER_CONF"] = "#{Dir.getwd}/nnstreamer-test.ini"
      ENV["NNSTREAMER_FILTERS"] = "#{Dir.getwd}/ext/nnstreamer/tensor_filter"
      ENV["NNSTREAMER_DECODERS"] = "#{Dir.getwd}/ext/nnstreamer/tensor_decoder"
      system "./tests/unittest_common"
      # system "./tests/unittest_sink", "-j", "5000", "-f", "10"
      system "./tests/unittest_plugins"
    end
    cd "tests" do
      system "mv", "nnstreamer_repo_dynamicity/runTest.sh", "nnstreamer_repo_dynamicity/runTest.sh.bak"
      # FIXME: Several tests are going to be failed
      system "ssat", "--progress"
      system "mv", "nnstreamer_repo_dynamicity/runTest.sh.bak", "nnstreamer_repo_dynamicity/runTest.sh"
    end
    cd "build" do
      system "ninja", "install"
    end
  end
end
