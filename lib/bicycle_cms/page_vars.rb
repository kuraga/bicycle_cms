# TODO Автоматизировать
require 'bicycle_cms/page_vars/breadcrumb'
require 'bicycle_cms/page_vars/property'

module BicycleCms
  module PageVars
    # TODO Унифицировать понятие переменной
    # TODO page_vars_depends_on

    extend ActiveSupport::Concern

    included do
      helper_method :page_vars_stylesheets, :page_vars_javascripts, :page_vars_description, :page_vars_keywords, :page_vars_title, :page_vars_breadcrumbs, :page_vars_page_title

      class_variable_set :@@stylesheets, [ ] unless class_variable_defined? :@@stylesheets
      class_variable_set :@@javascripts, [ ] unless class_variable_defined? :@@javascripts
      class_variable_set :@@description, [ ] unless class_variable_defined? :@@description
      class_variable_set :@@keywords,    [ ] unless class_variable_defined? :@@keywords
      class_variable_set :@@title,       [ ] unless class_variable_defined? :@@title
      class_variable_set :@@breadcrumbs, [ ] unless class_variable_defined? :@@breadcrumbs
    end

    # TODO Использовать хук
    def initialize(*)
      super
      instance_variable_set :@stylesheets, [ ] unless instance_variable_defined? :@stylesheets
      instance_variable_set :@javascripts, [ ] unless instance_variable_defined? :@javascripts
      instance_variable_set :@description, [ ] unless instance_variable_defined? :@description
      instance_variable_set :@keywords,    [ ] unless instance_variable_defined? :@keywords
      instance_variable_set :@title,       [ ] unless instance_variable_defined? :@title
      instance_variable_set :@breadcrumbs, [ ] unless instance_variable_defined? :@breadcrumbs
    end


    module ClassMethods

      def page_vars_add_stylesheets *stylesheets; class_variable_set(:@@stylesheets, class_variable_get(:@@stylesheets) + Array.wrap(stylesheets)); end
      def page_vars_add_javascripts *javascripts; class_variable_set(:@@javascripts, class_variable_get(:@@javascripts) + Array.wrap(javascripts)); end
      def page_vars_add_description description;  class_variable_set(:@@description, class_variable_get(:@@description) << description           ); end
      def page_vars_add_keywords    *keywords;    class_variable_set(:@@keywords,    class_variable_get(:@@keywords   ) << Array.wrap(keywords)  ); end
      def page_vars_add_title       title;        class_variable_set(:@@title,       class_variable_get(:@@title      ) << title                 ); end
      def page_vars_add_breadcrumbs *breadcrumbs; class_variable_set(:@@breadcrumbs, class_variable_get(:@@breadcrumbs) + Array.wrap(breadcrumbs)); end

    end

    def page_vars_add_stylesheets *stylesheets; instance_variable_set(:@stylesheets, instance_variable_get(:@stylesheets) + Array.wrap(stylesheets)); end
    def page_vars_add_javascripts *javascripts; instance_variable_set(:@javascripts, instance_variable_get(:@javascripts) + Array.wrap(javascripts)); end
    def page_vars_add_description description;  instance_variable_set(:@description, instance_variable_get(:@description) << description           ); end
    def page_vars_add_keywords    *keywords;    instance_variable_set(:@keywords,    instance_variable_get(:@keywords   ) << Array.wrap(keywords)  ); end
    def page_vars_add_title       title;        instance_variable_set(:@title,       instance_variable_get(:@title      ) << title                 ); end
    def page_vars_add_breadcrumbs *breadcrumbs; instance_variable_set(:@breadcrumbs, instance_variable_get(:@breadcrumbs) + Array.wrap(breadcrumbs)); end


    def page_vars_stylesheets; self.class.class_variable_get(:@@stylesheets) + @stylesheets; end
    def page_vars_javascripts; self.class.class_variable_get(:@@javascripts) + @javascripts; end
    def page_vars_description; (self.class.class_variable_get(:@@description) + @description).reverse.join(' '); end
    def page_vars_keywords;    (self.class.class_variable_get(:@@keywords) + @keywords).reverse.collect { |keywords_set| keywords_set.join(' ') }.join(' '); end
    def page_vars_title;       (self.class.class_variable_get(:@@title) + @title).reverse.join(' | ');           end
    def page_vars_page_title;  (self.class.class_variable_get(:@@title) + @title).last;      end
    def page_vars_breadcrumbs; self.class.class_variable_get(:@@breadcrumbs) + @breadcrumbs; end

  end
end
