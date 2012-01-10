class Class
  def inferred_type()
    klass_name   = self.name
    parent_klass = self.superclass
    while(parent_klass != nil)
      if (klass_name.end_with?(parent_klass.name))
        return klass_name.gsub(/#{parent_klass.name}\z/, "")
      end
      parent_klass = parent_klass.superclass
    end
    return nil
  end
end