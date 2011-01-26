module Convinius
  module Generator
    append_features Rubinius::Generator

    def make_tuple(count)
      push_rubinius
      find_const :Tuple
      move_down count
      send :[], count
    end
  end
end
