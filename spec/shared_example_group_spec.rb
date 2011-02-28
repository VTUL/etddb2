require "set"

shared_examples_for "a collection object" do
  describe "<<" do
    it "adds objects to the end of the collection" do
      collection << 1
      collection << 2
      collection.to_a.should eq([1,2])
    end
  end
end

describe Array do
  it_should_behave_like "a collection object" do
    let(:collection) { Array.new }
  end
end

describe Set do
  it_should_behave_like "a collection object" do
    let(:collection) { Set.new }
  end
end
