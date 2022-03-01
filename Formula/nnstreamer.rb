class Nnstreamer < Formula
  desc "Neural Network (NN) Streamer, Stream Processing Paradigm for Neural Network Apps/Devices."
  homepage "https://github.com/nnstreamer/nnstreamer"
  stable do
    url "https://github.com/nnstreamer/nnstreamer/archive/refs/tags/v2.0.0.tar.gz"
    version "2.0.0"
    sha256 "1282297ec55d1b87781c218b8ac313b24ae9636c6b41519a5c8435f71b07395a"
    patch do
      url "https://raw.githubusercontent.com/nnstreamer/homebrew-neural-network/master/Formula/nnstreamer-patches/0001-Local-Tests-Skip-the-SSAT-based-test-cases-that-fail.patch"
      sha256 "648e409ceec36247e5ba614d9feb0a807675d68441c8b194e9bfa98b636c539f"
    end
    patch do
      url "https://raw.githubusercontent.com/nnstreamer/homebrew-neural-network/master/Formula/nnstreamer-patches/0002-Local-Query-Common-Replace-EREMOTEIO-with-ENOTCONN.patch"
      sha256 "ff58094a81c98db97b4da9fe43b7180eae24e68e0512252d3105a3720c6d258c"
    end
    patch do
      url "https://raw.githubusercontent.com/nnstreamer/homebrew-neural-network/master/Formula/nnstreamer-patches/0003-Local-Tests-FilterExtCommon-Add-a-missing-parameter-.patch"
      sha256 "f2f5c0b5ad3a31889f945f19b1b484c863ad14295d5d5e67c6e188f87b8f24f7"
    end
    depends_on :macos
    depends_on "meson" => :build
    depends_on "ninja" => :build
    depends_on "pkg-config" => :build
    depends_on "cmake" => :build
    depends_on "googletest" => :build
    depends_on "ssat" => :build
    depends_on "bison"
    depends_on "flex"
    depends_on "protobuf"
    depends_on "libffi"
    depends_on "glib"
    depends_on "gstreamer"
    depends_on "gst-plugins-base"
    depends_on "gst-plugins-good"
    depends_on "numpy"
  end

  def install
    system "rm", "-rf", "build"
    system "meson", "build", "--prefix=#{prefix}", "--sysconfdir=#{prefix}/etc"
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
      # FIXME: Several tests are going to be failed
      system "ssat", "--progress"
    end
    cd "build" do
      system "ninja", "install"
    end
  end
end
