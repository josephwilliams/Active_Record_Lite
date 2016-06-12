class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method("#{name}=") do |value|
        ivar_name = "@#{name}"
        instance_variable_set(ivar_name, value)
      end
    end

    names.each do |name|
      define_method("#{name}") do
        getter_ivar_name = "@#{name}"
        instance_variable_get(getter_ivar_name)
      end
    end
  end
end
