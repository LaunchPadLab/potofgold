class Array
  
  def total
    self.remove_nil_and_replace_with_zero!
    self.inject{ |sum, el| sum + el }
  end
  
  def remove_nil_and_replace_with_zero!
    self.map! { |i| i.nil? ? 0 : i }
  end
  
end