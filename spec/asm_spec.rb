require 'convinius/asm'
require 'spec_helper'

describe Convinius::ASM do
  context 'asm with instance_eval' do
    include Convinius::ASM

    subject do
      asm do
        push 1
        push 2
        send :+, 1
      end
    end

    it { should respond_to(:call) }
    it { should evaluate_to(3) }
  end

  context 'new without instance_eval' do
    subject do
      Convinius::ASM.new do |g|
        g.push 1
        g.push 2
        g.send :+, 1
      end
    end

    it { should respond_to(:call) }
    it { should evaluate_to(3) }
  end
end
