require 'convinius/asm'
require 'convinius/generator'
require 'spec_helper'

describe Convinius::Generator do
  context 'make_tuple' do
    subject do
      Convinius::ASM.new do
        push 1
        push 2
        make_tuple 2
      end
    end

    it { should evaluate_to(Rubinius::Tuple[1, 2]) }
  end
end
