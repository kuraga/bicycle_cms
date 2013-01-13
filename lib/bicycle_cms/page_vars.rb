require 'bicycle_cms/page_vars/breadcrumb'

module BicycleCms
  module PageVars
    # TODO Унифицировать: понятие переменной
    # TODO Разобраться с вызовами {class,instance}_variable_{set,get}
    # TODO breadcrumbs

    extend ActiveSupport::Concern

    included do
      helper_method :page_vars_breadcrumbs, :page_vars_javascripts, :page_vars_stylesheets, :page_vars_description, :page_vars_keywords, :page_vars_title, :page_vars_page_title

      class_variable_set :@@stylesheets, [ ]                                                unless class_variable_defined? :@@stylesheets
      class_variable_set :@@javascripts, [ ]                                                unless class_variable_defined? :@@javascripts
      class_variable_set :@@description, [ configatron.global_description || [] ]           unless class_variable_defined? :@@description
      class_variable_set :@@keywords,    [ Array.wrap(configatron.global_keywords) || [] ] unless class_variable_defined? :@@keywords
      class_variable_set :@@title,       [ configatron.global_title || [] ]                 unless class_variable_defined? :@@title
      class_variable_set :@@breadcrumbs, [ ]                                                unless class_variable_defined? :@@breadcrumbs
    end

    # TODO Использовать хук
    def initialize *atts
      super *atts
      @stylesheets ||= [ ]
      @javascripts ||= [ ]
      @description ||= [ ]
      @keywords    ||= [ ]
      @title       ||= [ ]
      @breadcrumbs ||= [ ]
    end

    def page_vars_javascripts; self.class.class_variable_get(:@@javascripts) + @javascripts; end
    def page_vars_description; (self.class.class_variable_get(:@@description) + @description).reverse.join(' '); end
    def page_vars_keywords;    (self.class.class_variable_get(:@@keywords) + @keywords).reverse.collect { |keywords_set| keywords_set.join(' ') }.join(' '); end
    def page_vars_title;       (self.class.class_variable_get(:@@title) + @title).reverse.join(' | ');     end
    def page_vars_page_title;  (self.class.class_variable_get(:@@title) + @title).last;  end
    def page_vars_stylesheets; self.class.class_variable_get(:@@stylesheets) + @stylesheets; end
    def page_vars_breadcrumbs; self.class.class_variable_get(:@@breadcrumbs) + @breadcrumbs; end

    def page_vars_add_stylesheets *stylesheets; @stylesheets += Array.wrap(stylesheets); end
    def page_vars_add_javascripts *javascripts; @javascripts += Array.wrap(javascripts); end
    def page_vars_add_description description;  @description << description;             end
    def page_vars_add_keywords    *keywords;    @keywords    << Array.wrap(keywords);    end
    def page_vars_add_title       title;        @title       << title;                   end
    def page_vars_add_breadcrumbs *breadcrumbs; p breadcrumbs; @breadcrumbs += Array.wrap(breadcrumbs); end

    module ClassMethods

      def page_vars_add_stylesheets *stylesheets; class_variable_set(:@@stylesheets, class_variable_get(:@@stylesheets) + Array.wrap(stylesheets)); end
      def page_vars_add_javascripts *javascripts; class_variable_set(:@@javascripts, class_variable_get(:@@javascripts) + Array.wrap(javascripts)); end
      def page_vars_add_description description;  class_variable_set(:@@description, class_variable_get(:@@description) << description           ); end
      def page_vars_add_keywords    *keywords;    class_variable_set(:@@keywords,    class_variable_get(:@@keywords   ) << Array.wrap(keywords)  ); end
      def page_vars_add_title       title;        class_variable_set(:@@title,       class_variable_get(:@@title      ) << title                 ); end
      def page_vars_add_breadcrumbs *breadcrumbs; class_variable_set(:@@breadcrumbs, class_variable_get(:@@breadcrumbs) + Array.wrap(breadcrumbs)); end

      # TODO page_vars_depends_on

    end

  end
end
