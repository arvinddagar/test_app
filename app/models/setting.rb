# /app/models/setting.rb
class Setting < ActiveRecord::Base
  validates :name, presence: true
  validates :data_type, presence: true, on: [:update]

  DataTypes = %w{
    String
    Fixnum
    Float
    FalseClass
    TrueClass
  }
  class << self
  # This method returns the values of the config simulating a Hash, like:
  #   Setting[:foo]
  # It can also bring Arrays of keys, like:
  #   Setting[:foo, :bar]
  # ... so you can pass it to a method using *.
  # It is memoized, so it will be correctly cached.
    def [] *keys
      if keys.size == 1
        get keys.shift
      else
        keys.map { |key| get key }
      end
    end

    def []= key, value
      set key, value
    end

    def get_value type, value
      value =  case type
                when 'String' then value.to_s
                when 'Fixnum' then value.to_i
                when 'Float' then value.to_f
                when 'FalseClass' then !value
                when 'TrueClass' then !!value
               end
      value
    end

    private

    def get key
      Rails.cache.fetch("/settings/#{key}") do
        retrive_type(key) rescue nil
      end
    end

    def set key, value
      find_or_create_by!(name: key).update(value: value, data_type: "#{value.class}")
      Rails.cache.write("/settings/#{key}", value)
        value
    end

    def retrive_type key
      type = find_by(name: key)
      get_value(type.data_type, type.value)
    end
  end
end