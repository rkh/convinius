module Convinius
  module ToClass
    module ClassMethods
      extend_object Class

      def new(sclass = Object, *args)
        sclass = sclass.to_class if sclass.respond_to? :to_class
        super(sclass, *args)
      end
    end

    module InstanceMethods
      append_features Class

      def to_class
        self
      end
    end
  end
end
