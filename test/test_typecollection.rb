require 'helper'

# => Define a Type Collection
class SomeType
  include TypeCollection
end
# => Extend that Type Collection
class ExtendedSomeType < SomeType
  
end

class TestTypecollection < Test::Unit::TestCase
  should "Function inside packages" do
    # => Define a Type Collection
    class SomeType
      include TypeCollection
    end
    # => Extend that Type Collection
    class ExtendedSomeType < TestTypecollection::SomeType
      
    end
    # => Ensure it can be retrieved
    
    unless (TestTypecollection::SomeType.all_types().length == 1 and 
              TestTypecollection::SomeType.get_type("Extended") == TestTypecollection::ExtendedSomeType)
      flunk "Failed to Register TestTypecollection::Extended with TestTypecollection::SomeType!" 
    end
  end
  
  should "Function outside packages" do
    unless(SomeType.all_types().length == 1 and
            SomeType.get_type(ExtendedSomeType) == ExtendedSomeType)
      raise "Failed to register ExtendedSomeType with SomeType!"
    end
  end
end
