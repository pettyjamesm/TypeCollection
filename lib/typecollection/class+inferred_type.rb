class Class
  def __tc_collection_root()
    root = self
    while root.superclass && root.superclass.include?(TypeCollection::Base)
      root = root.superclass
    end
    root
  end

  def inferred_type()
    klass_name = self.name.split("::").last
    root_name = __tc_collection_root.name.split("::").last
    klass_name.gsub(root_name, "")
  end
end
