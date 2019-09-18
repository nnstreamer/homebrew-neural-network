class Googletest < Formula
  desc "Google Testing and Mocking Framework"
  homepage "https://github.com/google/googletest"
  url "https://github.com/google/googletest/archive/release-1.8.1.tar.gz"
  version "1.8.1"
  sha256 "9bf1fe5182a604b4135edc1a425ae356c9ad15e9b23f9f12a02e80184c3a249c"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build

  keg_only "this package is only to resolve build dependency of NNStreamer, not for system-wide dependencies"

  def install
    system "rm", "-rf", "build"
    system "mkdir", "-p", "build"
    Dir.chdir ("build")
    system "cmake", "..", "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    system "make"
    system "make", "install"
  end

end
