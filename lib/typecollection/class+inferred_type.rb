class Class
  def inferred_type()
    klass_name   = self.name.split("::").last
    parent_klass = self.superclass
    while(parent_klass != nil)
      check = parent_klass.name.split("::").last
      if (klass_name.match(check))
        return klass_name.gsub(/#{check}\z/, "")
      end
      parent_klass = parent_klass.superclass
    end
    return nil
  end
end