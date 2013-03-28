module TypeCollection
  NAME_DECOMPOSER = /(^|(?<namespace>.*):{2})(?<constant>[^:]+)$/
  class << self; attr_accessor :create_unknown_types; end

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
        raise TypeCollection::UnknownChildType.new("Unregistered type: #{type}") unless (mems.has_key?(type))
        return mems[type]
      end
      # Creates the type associated with the provided value (Class or Otherwise)
      def generate_type(type)
        type = type.inferred_type() if (type.kind_of?(Class))
        root = __tc_collection_root()

        name = TypeCollection::NAME_DECOMPOSER.match(root.name)

        new_type = Class.new(root)
        new_type_name = type + name[:constant]

        # Back away.  Just BACK. AWAY.
        #
        # We need to take this new class we've just created here
        # and assign it to a constant in the same namespace as its
        # collection root.  That may be the global namespace.
        # This mess accomplishes that.
        ::Kernel.instance_exec(new_type, &eval("->(klass){ #{name[:namespace]}::#{new_type_name} = klass }"))

        root.__tc_register_member(new_type)
        new_type
      end
      # Get similar type based on the object passed in which can be a String,
      # Object (using the inferred type), or Class
      def get_associated_type(associate, create_if_unknown=TypeCollection.create_unknown_types)
        if (!associate.kind_of?(String))
          if (!associate.kind_of?(Class))
            associate = associate.class
          end
          associate = associate.inferred_type()
        end
        begin
          self.get_type(associate)
        rescue TypeCollection::UnknownChildType => uct
          if create_if_unknown
            self.generate_type(associate)
          else
            raise
          end
        end
      end
    end

    def self.included(base)
      base.extend(TypeCollection::ClassMethods)
      base.extend(TypeCollection::Base::BaseClassMethods)
    end
  end
end
