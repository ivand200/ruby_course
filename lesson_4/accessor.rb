# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        define_method(attr) do
          instance_variable_get("@#{attr}")
        end

        define_method("#{attr}=") do |value|
          history_var = "@#{attr}_history"
          history = instance_variable_get(history_var) || []
          current_value = instance_variable_get("@#{attr}")
          history << instance_variable_get("@#{attr}")
          instance_variable_set(history_var, history.compact)

          instance_variable_set("@#{attr}", value)
        end

        define_method("#{attr}_history") do
          instance_variable_get("@#{attr}_history") || []
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      define_method(attr_name) do
        instance_variable_get("@#{attr_name}")
      end

      define_method("#{attr_name}=") do |value|
        raise TypeError, "Value type must be #{attr_class}" unless value.is_a?(attr_class)

        instance_variable_set("@#{attr_name}", value)
      end
    end
  end
end
