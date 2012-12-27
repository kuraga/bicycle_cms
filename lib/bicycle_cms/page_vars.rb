require 'bicycle_cms/page_vars/property'
require 'bicycle_cms/page_vars/breadcrumb'

module BicycleCms
  module PageVars
    # TODO Унифицировать: понятие переменной
    # TODO Разобраться с вызовами {class,instance}_variable_{set,get}
    # TODO breadcrumbs

    extend ActiveSupport::Concern

    included do
      helper_method :page_vars_breadcrumbs, :page_vars_javascripts, :page_vars_stylesheets, :page_vars_description, :page_vars_keywords, :page_vars_title, :page_vars_page_title

      # TODO Не устанавливать ли это в ApplicationController?
      class_variable_set :@@stylesheets, [ 'bicycle_cms/application' ]                      unless class_variable_defined? :@@stylesheets
      class_variable_set :@@javascripts, [ 'bicycle_cms/application' ]                      unless class_variable_defined? :@@javascripts
      class_variable_set :@@description, [ configatron.global_description || [] ]           unless class_variable_defined? :@@description
      class_variable_set :@@keywords,    [ Array.wrap(configatron.global_keywords) || [] ] unless class_variable_defined? :@@keywords
      class_variable_set :@@title,       [ configatron.global_title || [] ]                 unless class_variable_defined? :@@title
    end

    # TODO Использовать хук
    def initialize *atts
      super *atts
      @stylesheets ||= [ ]
      @javascripts ||= [ ]
      @description ||= [ ]
      @keywords    ||= [ ]
      @title       ||= [ ]
    end

    def page_vars_breadcrumbs; raise NotImplementedError;   end
    def page_vars_stylesheets; self.class.class_variable_get(:@@stylesheets) + @stylesheets; end
    def page_vars_javascripts; self.class.class_variable_get(:@@javascripts) + @javascripts; end
    def page_vars_description; (self.class.class_variable_get(:@@description) + @description).reverse.join(' '); end
    def page_vars_keywords;    (self.class.class_variable_get(:@@keywords) + @keywords).reverse.collect { |keywords_set| keywords_set.join(' ') }.join(' '); end
    def page_vars_title;       (self.class.class_variable_get(:@@title) + @title).reverse.join(' | ');     end
    def page_vars_page_title;  (self.class.class_variable_get(:@@title) + @title).last;  end

    def page_vars_add_breadcrumb  breadcrumb;  add_breadcrumb breadcrumb[:title], breadcrumb[:path];          end
    def page_vars_add_breadcrumbs breadcrumbs; breadcrumbs.each { |breadcrumb| page_vars_add_breadcrumb breadcrumb }; end
    def page_vars_add_stylesheet  stylesheet;  @stylesheets << stylesheet           if stylesheet.present?;   end
    def page_vars_add_javascript  javascript;  @javascripts << javascript           if javascript.present?;   end
    def page_vars_add_description description; @description << description          if description.present?;  end
    def page_vars_add_keywords    keywords;    @keywords    << Array.wrap(keywords) if keywords.present?;    end
    def page_vars_add_title       title;       @title       << title                if title.present?;        end

    module ClassMethods

      def page_vars_add_breadcrumb  breadcrumb;  add_breadcrumb breadcrumb[:title], breadcrumb[:path];          end
      def page_vars_add_breadcrumbs breadcrumbs; breadcrumbs.each { |breadcrumb| page_vars_add_breadcrumb breadcrumb }; end
      def page_vars_add_stylesheet  stylesheet;  class_variable_get(:@@stylesheets) << stylesheet           if stylesheet.present?;  end
      def page_vars_add_javascript  javascript;  class_variable_get(:@@javascripts) << javascript           if javascript.present?;  end
      def page_vars_add_description description; class_variable_get(:@@description) << description          if description.present?; end
      def page_vars_add_keywords    keywords;    class_variable_get(:@@keywords   ) << Array.wrap(keywords) if keywords.present?;    end
      def page_vars_add_title       title;       class_variable_get(:@@title      ) << title                if title.present?;       end

      # TODO page_vars_depends_on

    end

  end
end
