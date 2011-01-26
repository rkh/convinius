RSpec::Matchers.define(:evaluate_to) do |result|
  match { |cm| cm.call.should == result }
end
