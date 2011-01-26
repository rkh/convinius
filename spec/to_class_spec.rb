require 'convinius/to_class'

describe Convinius::ToClass do
  subject do
    class_loop = Object.new

    class << class_loop
      attr_accessor :pos
      attr_accessor :list

      def to_class
        sclass = list.at(pos % list.size)
        self.pos += 1
        sclass
      end
    end

    class_loop
  end

  before do
    subject.pos = 0
  end

  it 'should not break normal subclassing' do
    class Foo; end
    class Bar < Foo; end
    Foo.superclass.should == Object
    Bar.superclass.should == Foo
  end

  it 'should allow custom subclassing logic' do
    subject.list = [Object, Array, Hash]
    Class.new(subject).superclass == Object
    Class.new(subject).superclass == Array
    Class.new(subject).superclass == Hash
  end

  it 'should work with subclassing syntax' do
    subject.list = [Object, Array, Hash]
    class FromObject < subject; end
    class FromArray  < subject; end
    class FromHash   < subject; end
    FromObject.superclass.should == Object
    FromArray.superclass.should  == Array
    FromHash.superclass.should   == Hash
  end
end
