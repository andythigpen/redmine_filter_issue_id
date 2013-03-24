# Only used for version 2.3
require_dependency 'issue_query'

module IssueQueryPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :initialize_available_filters, :id_filter
    end
  end

  module InstanceMethods
    def initialize_available_filters_with_id_filter
      initialize_available_filters_without_id_filter
      add_available_filter "id", :type => :text
    end

    def sql_for_id_field(field, operator, value)
      v = value.first.scan(/\d+/).join(',')

      sql = ""
      case operator
      when "~"
        sql = "#{queried_table_name}.id in (#{v})"
      when "!~"
        sql = "#{queried_table_name}.id NOT in (#{v})"
      end

      return sql
    end
  end
end

IssueQuery.send(:include, IssueQueryPatch)

