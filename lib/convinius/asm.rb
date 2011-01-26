module Convinius
  module ASM
    extend self

    def asm(file = "(asm)", line = 1, method = :call, &block)
      code = Object.new
      Rubinius.object_metaclass(code).dynamic_method(method, file, line) do |g|
        block.arity > 0 ? yield(g) : g.instance_eval(&block)
        g.ret
      end
      code
    end

    class << self
      alias new asm
    end
  end
end
