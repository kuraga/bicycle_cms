require 'formtastic'
require 'bicycle_cms/panels'

# TODO Класс вне BicycleCms
class PanelLinkAction < Formtastic::Actions::LinkAction

  def supported_methods
    object_model_names = object.model_class.ancestors.select { |klass| klass.is_a? Class }.take_while { |klass| ActiveRecord::Base != klass }.map { |ancestor| ancestor.model_name.to_s }

    object_model_names.each do |object_model_name|
      begin
        return "BicycleCms::Panels::#{object_model_name.demodulize.camelize}Panel".constantize.supported_capabilities
      rescue NameError
      end
    end

    # TODO autoload?
    []
  end

  def to_html
    object_model_names = object.model_class.ancestors.select { |klass| klass.is_a? Class }.take_while { |klass| ActiveRecord::Base != klass }.map { |ancestor| ancestor.model_name.to_s }

    wrapper do
      object_model_names.each do |object_model_name|
        begin
          return template.send "#{method}_#{object_model_name.demodulize.underscore}_link", object
        rescue NoMethodError
        end
      end

      ''
    end
  end

end
