require 'active_support/concern'
require 'active_support/lazy_load_hooks'

module ActiveRecord
  module HumanizedEnum
    extend ActiveSupport::Concern

    class_methods do
      ENUM_HUMANIZABLE_CONFLICT_MESSAGE = \
        "You tried to humanize an enum named \"%{enum}\" on the model \"%{klass}\", but " \
        "this will generate a %{type} method \"%{method}\", which is already defined " \
        "by %{source}."

      def enum(*args, **kwargs)
        definitions = super(*args, **kwargs)
        humanized_enum(*definitions.keys)
      end

      def humanized_enum(*enums)
        klass = self
        enums.each do |enum|
          enum = enum.to_s
          method_name = "humanized_#{enum}"

          # def self.humanized_status(status) ... end
          detect_humanized_enum_conflict! enum, method_name, true
          klass.singleton_class.send :define_method, method_name do |enum_value|
            I18n.t enum_value.to_sym, scope: [:activerecord, :attributes, klass.model_name.i18n_key, enum.pluralize.to_sym], default: enum_value.to_s.humanize if enum_value.present?
          end

          # def humanized_status ... end
          detect_humanized_enum_conflict! enum, method_name
          define_method method_name do
            klass.send method_name.to_sym, send(enum.to_sym)
          end
        end
      end

      private

      def detect_humanized_enum_conflict!(enum_name, method_name, klass_method = false)
        if klass_method && dangerous_class_method?(method_name)
          raise ArgumentError, ENUM_HUMANIZABLE_CONFLICT_MESSAGE % {
            enum: enum_name,
            klass: self.name,
            type: 'class',
            method: method_name,
            source: 'Active Record'
          }
        elsif !klass_method && dangerous_attribute_method?(method_name)
          raise ArgumentError, ENUM_HUMANIZABLE_CONFLICT_MESSAGE % {
            enum: enum_name,
            klass: self.name,
            type: 'instance',
            method: method_name,
            source: 'Active Record'
          }
        elsif klass_method && respond_to?(method_name)
          raise ArgumentError, ENUM_HUMANIZABLE_CONFLICT_MESSAGE % {
            enum: enum_name,
            klass: self.name,
            type: 'class',
            method: method_name,
            source: 'another humanized enum'
          }
        elsif !klass_method && method_defined?(method_name)
          raise ArgumentError, ENUM_HUMANIZABLE_CONFLICT_MESSAGE % {
            enum: enum_name,
            klass: self.name,
            type: 'instance',
            method: method_name,
            source: 'another humanized enum'
          }
        end
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  include ActiveRecord::HumanizedEnum
end
