require 'active_support/inflector'
require 'typecollection'
require 'typecollection/class+inferred_type'
require 'typecollection/class_methods'

module TypeCollection
  # The intended means to use a TypeCollection is to include TypeCollection
  # in your class definition.
  def self.included(base)
    base.extend(TypeCollection::ClassMethods)
  end
end
