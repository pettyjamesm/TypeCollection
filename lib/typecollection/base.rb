module TypeCollection
  module Base
    
    module BaseClassMethods
      # Returns all of the known subclass names for this collection
      def all_type_names(); return __tc_members().keys(); end
      # Returns all of the known subclasses for this collection
      def all_types(); return __tc_members().values(); end
      # Gets the type associated with the provided value (Class or Otherwise)
      def get_type(type)
        type = type.inferred_type() if (type.kind_of?(Class))
        mems = __tc_members()
        raise TypeCollection::UnknownChildType.new() unless (mems.has_key?(type))
        return mems[type]
      end
    end
    
    def self.included(base)
      base.extend(TypeCollection::ClassMethods)
      base.extend(TypeCollection::Base::BaseClassMethods)
    end
  end
end