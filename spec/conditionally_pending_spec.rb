describe "a failing spec" do
  def run_test; raise "failure"; end

  it "is pending when pending with a true :if condition" do
    pending("true :if", :if => true) { run_test }
  end

  it "fails when pending with a false :if condition" do
    pending("false :if", :if => false) { run_test }
  end

  it "is pending when pending with a false :unless condition" do
    pending("false :unless", :unless => false) { run_test }
  end

  it "fails when pending with a true :unless condition" do
    pending("true :unless", :unless => true) { run_test }
  end
end

describe "a passing spec" do
  def run_test; true.should be(true); end

  it "fails when pending with a true :if condition" do
    pending("true :if", :if => true) { run_test }
  end

  it "passes when pending with a false :if condition" do
    pending("false :if", :if => false) { run_test }
  end

  it "fails when pending with a false :unless condition" do
    pending("false :unless", :unless => false) { run_test }
  end

  it "passes when pending with a true :unless condition" do
    pending("true :unless", :unless => true) { run_test }
  end
end
