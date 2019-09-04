class Ssat < Formula
  desc "Shell Script Automated Tester (unit testing executable files)"
  homepage "https://github.com/myungjoo/SSAT"
  url "https://github.com/nnsuite/SSAT/archive/fa636a9882e920f9cb1dbc2e4e96082b86f4776f.zip"
  version "1.0.0"
  sha256 "ff0acc26aa224ae6c78e12347b78478f38452af440b0932b2fe8145912e02ce7"

  def install
    system "ln","-s","ssat.sh", "ssat"
	bin.install "ssat-api.sh"
	bin.install "ssat.sh"
	bin.install "ssat"
  end

end
