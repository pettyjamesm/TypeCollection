class Class
  def inferred_type()
    if (!defined?(@__tc_inferred_type))
      klass_name   = self.name.split("::").last
      parent_klass = self.superclass
      while(parent_klass != nil)
        check = parent_klass.name.split("::").last
        if (klass_name.end_with?(check))
          @__tc_inferred_type = klass_name.gsub(/#{check}\z/, "")
          break
        end
        parent_klass = parent_klass.superclass
      end
      @__tc_inferred_type = nil
    end
    return @__tc_inferred_type
  end
end