module Convinius
  module ASM
    extend self

    def asm(file = "(asm)", line = 1, method = :call, &block)
      g = Rubinius::Generator.new
      g.name = method.to_sym
      g.file = file.to_sym
      g.set_line line

      g.required_args = 0
      g.total_args = 0
      g.splat_index = nil

      g.local_count = 0
      g.local_names = []

      block.arity > 0 ? yield(g) : g.instance_eval(&block)

      g.ret
      g.close

      g.encode
      cm = g.package Rubinius::CompiledMethod
      puts cm.decode if $DEBUG

      code = Object.new
      ss = Rubinius::StaticScope.new Object
      Rubinius.attach_method g.name, cm, ss, code

      code
    end

    class << self
      alias new asm
    end
  end
end
