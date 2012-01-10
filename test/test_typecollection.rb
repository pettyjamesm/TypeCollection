require 'helper'

class TestTypecollection < Test::Unit::TestCase
  should "Actually Function" do
    require 'typecollection'
    # => Define a Type Collection
    class SomeType
      include TypeCollection
    end
    # => Extend that Type Collection
    class ExtendedSomeType < SomeType
      
    end
    # => Ensure it can be retrieved
    unless (SomeType.all_types().length == 1 and SomeType.get_type("Extended") == ExtendedSomeType)
      flunk "Failed to Register Extended with SomeType!" 
    end
  end
end
