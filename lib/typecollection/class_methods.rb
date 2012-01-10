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
    
    # Overrides the default behavior when being extended by a child class.
    # It ensures the child is mapped for future retrieval and checks the
    # subclass name to ensure it is a valid one
    def inherited(child)
      super if (defined?(super))
      type = child.inferred_type()
      if (type.nil?)
        cname = child.name.split("::").last
        pname = self.name.split("::").last
        error = "Invalid Name: #{ cname }! Child class names must end with \"#{ pname }\"."
        raise TypeCollection::InvalidChildType.new(error)
      end
      __tc_members()[type] = child
    end
  end
end