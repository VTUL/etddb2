describe "an example" do
  it "is implemented but waiting" do
    pending("something else getting finished") do
      raise "this is the failure"
    end
  end
end
