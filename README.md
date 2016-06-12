# Active Record Lite
An ORM inspired by Rails' Active Record and designed with Ruby RSPEC to ensure test-driven development.

## Features
- Easy, English-like SQL queries using associations

- Quick, clean getter and setter methods through
```ruby
attr_accessor
```
```ruby
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
```
