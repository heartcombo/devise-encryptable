module Support
  module Swappers
    def swap_with_encryptor(klass, encryptor, options={})
      klass.instance_variable_set(:@encryptor_class, nil)

      swap klass, options.merge(:encryptor => encryptor) do
        begin
          yield
        ensure
          klass.instance_variable_set(:@encryptor_class, nil)
        end
      end
    end

    def swap(object, new_values)
      old_values = {}
      new_values.each do |key, value|
        old_values[key] = object.send key
        object.send :"#{key}=", value
      end
      yield
    ensure
      old_values.each do |key, value|
        object.send :"#{key}=", value
      end
    end
  end
end