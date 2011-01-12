# This module is used to convert a base10 integer into an equivalent base31 guid string (and vice-versa).
# The base31 number is represented as a alpha-numeric characters (excluding the vowel charatcers A, E, I, O, U); 
# this is done to avoid confusion between numbers and letters (eg. 1 and I, 0 and O) and also to avoid
# nasty words from being generated from their equivalent decimal values.

class Base31encoder
  # base31/base10 equivalent string definitions
  Dec_vals = {
    "0" => "0","1" => "1","2" => "2","3" => "3","4" => "4","5" => "5",
    "6" => "6","7" => "7","8" => "8","9" => "9","10" => "B","11" => "C",
    "12" => "D","13" => "F","14" => "G","15" => "H","16" => "J",
    "17" => "K","18" => "L","19" => "M","20" => "N","21" => "P",
    "22" => "Q","23" => "R","24" => "S","25" => "T","26" => "V",
    "27" => "W","28" => "X","29" => "Y","30" => "Z","B" => "10",
    "C" => "11","D" => "12","F" => "13","G" => "14","H" => "15",
    "J" => "16","K" => "17","L" => "18","M" => "19","N" => "20",
    "P" => "21","Q" => "22","R" => "23","S" => "24","T" => "25",
    "V" => "26","W" => "27","X" => "28","Y" => "29","Z" => "30"
  }
  
  def initialize(base_length=6)
    @base_length = base_length
  end
  
  def base31str_to_int(str)
    if not str.is_a?(String)
      raise StandardError, "Received value is not a valid string"
    end
    
    len = pos = str.length
    total = 0
    
    while pos > 0 do
      val = str[(len - pos), 1]
      intval = Dec_vals[val].to_i
      
      tmp = pos
      while (tmp - 1) > 0 do
        intval = intval * 31
        tmp -= 1
      end
      
      total += intval
      pos -= 1
    end
    
    return total
  end
  
  def int_to_base31(num)
    if not num.is_a?(Integer)
      raise StandardError, "Received value is not a valid integer"
    end
    
    base31 = ""
    
    while num > 0 do
      rem = num % 31
      num = num / 31
      val = Dec_vals[rem.to_s]
      
      base31 = val + base31
    end
    
    while base31.length < @base_length do
      base31 = "0" + base31
    end
    
    return base31
  end
end