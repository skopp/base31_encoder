require 'helper'

class TestBase31Encoder < Test::Unit::TestCase
  $base10num = 12345
  
  should "testing conversion from base10 to base31" do
    obj = Base31encoder.new(base_length=5)
    $base31num = obj.int_to_base31($base10num)
  end
  
  should "testing conversion from base31 to base10 - and that numbers are correctly converted" do
    obj = Base31encoder.new(base_length=5)
    newbase10num = obj.base31str_to_int($base31num)
    
    if not newbase10num == $base10num
      flunk "Conversions did not return valid numbers between conversions - logic error in base31_guid"
    end
  end
end
