class Ssat < Formula
  desc "Shell Script Automated Tester (unit testing executable files)"
  homepage "https://github.com/myungjoo/SSAT"
  # SSAT has had no tagged release since v1.2.0; pin the 1.4.0 tree, which adds
  # the gstTestBackground API that NNStreamer's test groups require.
  url "https://github.com/myungjoo/SSAT/archive/6f94498fbb615b1d34f419222e39da9680dd7300.tar.gz"
  version "1.4.0"
  sha256 "b76c5a7b03554f1074164518adc424276b328fb55607b17928a727196c631099"
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
