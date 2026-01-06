class Goperf < Formula
  desc "Preventive performance analysis for Go - catch O(n²) loops and N+1 queries"
  homepage "https://github.com/cschuman/goperf"
  url "https://github.com/cschuman/goperf/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1a5cde71c7198c755a62419e3efe64c39ec44b82cd423ab2c7257ea0e3c0a25f"
  license "MIT"
  head "https://github.com/cschuman/goperf.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=#{tap.user}
      -X main.date=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/goperf --version")
    
    # Test basic analysis
    (testpath/"test.go").write <<~EOS
      package main
      func main() {
        var s string
        for i := 0; i < 100; i++ {
          s += "x"
        }
      }
    EOS
    output = shell_output("#{bin}/goperf #{testpath}/test.go 2>&1", 0)
    assert_match "string-concat-loop", output
  end
end
