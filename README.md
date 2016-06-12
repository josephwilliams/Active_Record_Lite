# Active Record Lite
An ORM inspired by Rails' Active Record and designed with Ruby RSPEC to ensure test-driven development.

## Features
- Easy, English-like SQL queries using associations
- Quick, clean getter and setter methods through 'attr_accessor':
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
- Use of Rails' 'has_many', 'belongs_to', and 'has_one_through' associations
```ruby
module Associatable
  def belongs_to(name, options = {})
    self.assoc_options[name] = BelongsToOptions.new(name, options)

    define_method(name) do
      options = self.class.assoc_options[name]

      key_val = self.send(options.foreign_key)
      options
        .model_class
        .where(options.primary_key => key_val)
        .first
    end
  end

  def has_many(name, options = {})
    self.assoc_options[name] =
      HasManyOptions.new(name, self.name, options)

    define_method(name) do
      options = self.class.assoc_options[name]

      key_val = self.send(options.primary_key)
      options
        .model_class
        .where(options.foreign_key => key_val)
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
end
```
- Ability to save and update models
