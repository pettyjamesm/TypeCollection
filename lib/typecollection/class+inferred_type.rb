class Class
  def inferred_type()
    klass_name   = self.name.demodulize
    parent_klass = self.superclass
    while(parent_klass != nil)
      check = parent_klass.name.split("::").last
      if (klass_name.end_with?(check))
        return klass_name.gsub(/#{check}\z/, "")
      end
      parent_klass = parent_klass.superclass
    end
    return nil
  end
end