Convinius
=========

Convenience library for Rubinius-only projects.
Use `require 'convinius'` to get all features.

Installation:

    gem install convinius

Running tests:

    gem install rspec
    rspec spec

Subclassing from arbitrary Objects
----------------------------------
in: `convinius/to_class`

If you subclass from an object, first call `to_class` on that object and
subclass the result instead:

    RandomClass = Object.new
    
    def RandomClass.to_class
      [Hash, Object, Set].at rand(3)
    end
    
    class Foo < RandomClass
      puts superclass
    end

A more realistic example:

    module Awesome
      def self.to_class
        Class.new { include Awesome }
      end
    end
    
    class Foo < Awesome
    end
    
    class Bar < Something
      include Awesome
    end

Import constants from Rubinius
------------------------------
in: `convinius/globals`

Defines global constants `Tuple` and `Fiber`.

Convenience for Rubinius::Generator
-----------------------------------
in: `convinius/generator`

Method for generating tuples (like `make_array`):

    class MyNode < Rubinius::AST::Node
      def bytecode(g)
        (1..5).each { |i| g.push i }
        g.make_tuple 5
      end
    end

Byte Code Generator DSL
-----------------------
in: `convinius/asm`

Example:

    include Convinius::ASM

    compiled = asm do
      push 1
      push 2
      send :+, 1
    end
    
    p compiled.call

If block takes an argument, it won't use `instance_eval`:

    Convinius::ASM.new do |g|
      g.push 1
      g.push 2
      g.send :+, 1
    end
