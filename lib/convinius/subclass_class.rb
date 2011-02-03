module Convinius
  module SubclassClass
    extend_object Class

    def new(*)
      result = super
      Rubinius::Unsafe.set_class result, self if self != Class
      result
    end
  end
end
