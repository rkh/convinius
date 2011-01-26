module Convinius
  module ASM
    extend self

    def asm(opts = {}, &block)
      object = opts[:object] || Object.new
      opts = { :file => "(asm)", :line => 1, :method => :call }.merge! opts
      Rubinius.object_metaclass(object).dynamic_method(opts[:method], opts[:file], opts[:line]) do |g|
        block.arity > 0 ? yield(g) : g.instance_eval(&block)
        g.ret
      end
      object
    end

    class << self
      alias new asm
    end
  end
end
