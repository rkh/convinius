require 'convinius/subclass_class'
require 'spec_helper'

describe Convinius::SubclassClass do
  it 'should allow using subclasses of Class' do
    example = Class.new Class
    klass = example.new
    klass.new.class.should == klass
    klass.class.should == example
  end
end
