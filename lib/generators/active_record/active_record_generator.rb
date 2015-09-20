require 'rails/generators/active_record/model/model_generator'
#require File.join(File.dirname(__FILE__), '../test_unit/model_generator')
require File.join(File.dirname(__FILE__), '../base')

module BatchScaffold
  module Generators
    class ActiveRecordGenerator < ::ActiveRecord::Generators::ModelGenerator
      include ::BatchScaffold::Base

      #source_root superclass.source_root
      source_root File.expand_path('../migration/templates', __FILE__)

      def initialize(args, *options) #:nodoc:
binding.pry
        super
        puts 'hoge'
        # #DIRTY HACK remove noise. don't know why but the first attribute type is always suffixed by " #{parent_name}"
        # attributes.each do |attribute|
        #   attribute.type = attribute.type.to_s.split(' ').first if attribute.type.to_s.include?(' ')
        # end
        # # prefer parent:references to parent_id:integer
        # attributes.delete_if {|a| (a.name == nested_parent_id) && (a.type.to_s == 'integer')}
        # unless attributes.map {|a| [a.name, a.type.to_s]}.include? [nested_parent_name, 'references']
        #   #DIRTY HACK add 'references' attribute
        #   attributes.insert 0, Rails::Generators::GeneratedAttribute.new(nested_parent_name, 'references')
        # end
      end

      def create_migration_file
        return unless options[:migration] && options[:parent].nil?
        attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
binding.pry
        migration_template "create_table_migration.rb", "db/migrate/create_#{table_name}.rb"
      end
      #
      # #hook_for :test_framework, :in => 'batch_scaffold:model'
      #
      #
      # # add has_many_association to parent model
      # def add_association
      #   if File.exist?(parent_file = File.join('app/models', "#{nested_parent_name}.rb"))
      #     inject_into_file parent_file, "  has_many :#{table_name}\n", :after => " < ActiveRecord::Base\n"
      #   end
      # end
      #
      # protected
      # def migration_action; 'add'; end
    end
  end
end
