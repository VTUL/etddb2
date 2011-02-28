RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_has_behavior, 'has behavior:'
end

shared_examples_for 'sortability' do
  it 'responds to <=>' do
    sortable.should respond_to(:<=>)
  end
end

describe String do
  it_has_behavior 'sortability' do
    let(:sortable) { 'sample string' }
  end
end
