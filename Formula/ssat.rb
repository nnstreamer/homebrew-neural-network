class Ssat < Formula
  desc "Shell Script Automated Tester (unit testing executable files)"
  homepage "https://github.com/myungjoo/SSAT"
  url "https://github.com/nnsuite/SSAT/archive/60a2e405bdd466dcc839c90a4075a5a42c6302fe.zip"
  version "1.0.0"
  sha256 "2d5a6d777c20e8d795521d0f1d835ae2dfcebe5de57b28db486eb1f3adb541fe"

  def install
    system "ln","-s","ssat.sh", "ssat"
	bin.install "ssat-api.sh"
	bin.install "ssat.sh"
	bin.install "ssat"
  end

end
