module TypeCollection
  # Indicates that a TypeCollection has been extended by a base class that
  # fails to comply with the correct naming convention for TypeCollection
  # to function properly
  class InvalidChildType < StandardError; end
  
  # Indicates that a request has been made to retrieve a child type that
  # is not currently registered with the type collection
  class UnknownChildType < StandardError; end
  
  # Extended by TypeCollections to provide class level functionality (almost
  # all functionality is class level as of the current design)
  module ClassMethods
    # Contains the Members mapped by type
    def __tc_members(); @_members ||= { }; end
    
    # Returns all of the known subclasses for this collection
    def all_types()
      return __tc_members().values()
    end
    
    # Gets the type associated with the provided value (Class or Otherwise)
    def get_type(type)
      type = type.inferred_type() if (type.kind_of?(Class))
      mems = __tc_members()
      raise TypeCollection::UnknownChildType.new() unless (mems.has_key?(type))
      return mems[type]
    end
    
    # Overrides the default behavior when being extended by a child class.
    # It ensures the child is mapped for future retrieval and checks the
    # subclass name to ensure it is a valid one
    def inherited(child)
      super if (defined?(super))
      type = child.inferred_type()
      if (type.nil?)
        error = "Invalid Name: #{child.name}! Child class names must end with \"#{self.name}\"."
        raise TypeCollection::InvalidChildType.new(error)
      end
      __tc_members()[type] = child
    end
  end
end