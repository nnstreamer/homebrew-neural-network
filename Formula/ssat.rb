class Ssat < Formula
  desc "Shell Script Automated Tester (unit testing executable files)"
  homepage "https://github.com/myungjoo/SSAT"
  url "https://github.com/myungjoo/SSAT/archive/refs/tags/v1.2.0.tar.gz"
  version "1.2.0"
  sha256 "37c8c1bbd5561792d45c233328d86bbffe0534eca30f6681d50f7390d4dfabaa"

  def install
    system "ln","-s","ssat.sh", "ssat"
	bin.install "ssat-api.sh"
	bin.install "ssat.sh"
	bin.install "ssat"
  end

end
