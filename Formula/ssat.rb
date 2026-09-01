class Ssat < Formula
  desc "Shell Script Automated Tester (unit testing executable files)"
  homepage "https://github.com/myungjoo/SSAT"
  # SSAT has had no tagged release since v1.2.0, so pin a commit on main. This
  # one is the 1.4.0 tree, which adds the gstTestBackground API that
  # NNStreamer's test groups require, plus myungjoo/SSAT#27, without which
  # callCompareTest's prefix comparison is broken on macOS.
  url "https://github.com/myungjoo/SSAT/archive/75e18c1c03c5b6218c2819712bf2a30db8f6f378.tar.gz"
  version "1.4.0"
  sha256 "3ec0979b14fb2671a21234475367aba419feeb0c3f749b2e4671cfe99470e2da"
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
