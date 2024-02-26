# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.class_variable_set(:@@validations, []) unless base.class_variable_defined?(:@@validations)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      class_variable_get(:@@validations)
    end

    def validate(name, type, option = nil)
      validations = class_variable_get(:@@validations)
      validations << { name: name, type: type, option: option }
      class_variable_set(:@@validations, validations)
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}")
        send("validate_#{validation[:type]}", value, validation[:option])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(value, _option)
      raise 'Value cannot be nil or empty' if value.nil? || value.to_s.empty?
    end

    def validate_format(value, format)
      raise 'Value does not match format' if value !~ format
    end

    def validate_type(value, type)
      raise "Value is not of type #{type}" unless value.is_a? type
    end
  end
end
