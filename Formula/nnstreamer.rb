class Nnstreamer < Formula
  desc "Neural Network (NN) Streamer, Stream Processing Paradigm for Neural Network Apps/Devices."
  homepage "https://github.com/nnstreamer/nnstreamer"
  url "https://github.com/nnstreamer/nnstreamer/archive/refs/tags/v2.6.0.tar.gz"
  sha256 "8f28c5c6020c4d3b91c4688ade559757a2c2caccebffaacec34642c980c8bfec"
  license "LGPL-2.1-only"

  depends_on :macos
  depends_on "cmake" => :build
  depends_on "googletest" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "ssat" => :build
  depends_on "bison"
  depends_on "flex"
  depends_on "glib"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-good"
  depends_on "gstreamer"
  depends_on "json-glib"
  depends_on "libffi"
  depends_on "libpng"
  depends_on "numpy"
  depends_on "protobuf"

  def install
    # orcc-support off: unittest_plugins.cc does not compile against orc on
    # macOS (nnstreamer/nnstreamer#4862). This also drops the Orc SIMD path from
    # the installed tensor_transform, which falls back to scalar C.
    system "meson", "setup", "build",
           "--prefix=#{prefix}",
           "--sysconfdir=#{prefix}/etc",
           "-Dorcc-support=disabled"
    system "meson", "compile", "-C", "build"

    # Build-time verification, mirroring nnstreamer's own macOS CI environment.
    build_root = buildpath/"build"
    ENV["NNSTREAMER_BUILD_ROOT_PATH"] = build_root.to_s
    ENV["NNSTREAMER_CONF"] = (build_root/"nnstreamer-test.ini").to_s
    ENV["NNSTREAMER_FILTERS"] = (build_root/"ext/nnstreamer/tensor_filter").to_s
    ENV["NNSTREAMER_DECODERS"] = (build_root/"ext/nnstreamer/tensor_decoder").to_s
    ENV["NNSTREAMER_CONVERTERS"] = (build_root/"ext/nnstreamer/tensor_converter").to_s
    ENV["GST_PLUGIN_PATH"] = (build_root/"gst").to_s
    system "meson", "test", "-C", "build", "-v", "unittest_common", "unittest_plugins"
    cd "tests" do
      system "ssat", "--progress=1"
    end

    system "meson", "install", "-C", "build"
  end

  test do
    ENV["GST_PLUGIN_PATH"] = (lib/"gstreamer-1.0").to_s
    ENV["NNSTREAMER_CONF"] = (prefix/"etc/nnstreamer.ini").to_s
    system "gst-launch-1.0", "-q", "videotestsrc", "num-buffers=1", "!",
           "video/x-raw,format=RGB,width=16,height=16,framerate=5/1", "!",
           "tensor_converter", "!", "tensor_sink"
  end
end
