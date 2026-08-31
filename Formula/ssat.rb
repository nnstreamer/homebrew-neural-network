class Ssat < Formula
  desc "Shell Script Automated Tester (unit testing executable files)"
  homepage "https://github.com/myungjoo/SSAT"
  # SSAT has had no tagged release since v1.2.0, so pin a commit. This one is
  # the 1.4.0 tree, which adds the gstTestBackground API that NNStreamer's test
  # groups require, plus myungjoo/SSAT#27, without which callCompareTest's
  # prefix comparison is broken on macOS.
  url "https://github.com/myungjoo/SSAT/archive/f6e6021ad58c44df536be8cf80e5292a561deb30.tar.gz"
  version "1.4.0"
  sha256 "53baca7653c4fd71a109c8fcf141ab2c638399914ab7d66896019e56acf76580"
  license "Apache-2.0"

  def install
    bin.install "ssat-api.sh"
    bin.install "ssat.sh"
    bin.install_symlink bin/"ssat.sh" => "ssat"
  end

  test do
    assert_match "1.4.0", shell_output("#{bin}/ssat --version")
  end
end
