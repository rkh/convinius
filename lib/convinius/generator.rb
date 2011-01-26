module Convinius
  module Generator
    append_features Rubinius::Generator

    def make_tuple(count)
      push count
      invoke_primitive :tuple_allocate, 1
      (count - 1).downto(0) do |i|
        dup
        rotate 3
        push i
        swap
        invoke_primitive :tuple_put, 3
        pop
      end
    end
  end
end
