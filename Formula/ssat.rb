class Ssat < Formula
  desc "Shell Script Automated Tester (unit testing executable files)"
  homepage "https://github.com/myungjoo/SSAT"
  url "https://github.com/myungjoo/SSAT/archive/103e4f88ac32f3fdba394fccd6007e99debac159.zip"
  version "1.0.0"
  sha256 "92ebd6f644f93595b5815ecb2dd75c7cc7095b851ccea37091732c7f75a6571a"

  def install
    system "ln","-s","ssat.sh", "ssat"
	bin.install "ssat-api.sh"
	bin.install "ssat.sh"
	bin.install "ssat"
  end

end
