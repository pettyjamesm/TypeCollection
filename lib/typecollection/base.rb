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
        raise TypeCollection::UnknownChildType.new("Unregisterred type: #{type}") unless (mems.has_key?(type))
        return mems[type]
      end
      # Get similar type based on the object passed in which can be a String, 
      # Object (using the inferred type), or Class
      def get_associated_type(associate)
        if (!associate.kind_of?(String))
          if (!associate.kind_of?(Class))
            associate = associate.class
          end
          associate = associate.inferred_type()
        end
        return self.get_type(associate)
      end
    end
    
    def self.included(base)
      base.extend(TypeCollection::ClassMethods)
      base.extend(TypeCollection::Base::BaseClassMethods)
    end
  end
end