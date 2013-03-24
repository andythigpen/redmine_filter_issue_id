# Only used for version 2.2.3
require_dependency 'query'

module QueryPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :available_filters, :id_filter
    end
  end

  module InstanceMethods
    def available_filters_with_id_filter
      filters = available_filters_without_id_filter
      filters["id"] = { :type => :text, :order => 15, :name => l("field") }
      return filters
    end

    def sql_for_id_field(field, operator, value)
      v = value.first.scan(/\d+/).join(',')

      sql = ""
      case operator
      when "~"
        sql = "#{Issue.table_name}.id in (#{v})"
      when "!~"
        sql = "#{Issue.table_name}.id NOT in (#{v})"
      end

      return sql
    end
  end
end

Query.send(:include, QueryPatch)

