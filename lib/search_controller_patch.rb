require_dependency 'search_controller'

module SearchControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :index, :multiple_id
    end
  end

  module InstanceMethods
    def index_with_multiple_id
      question = params[:q] || ""
      if question.match(/^(#?(\d+))([,\s]+#?(\d+)\s*)+$/)
        redirect_to issues_url(:set_filter => 1,
                               :f => ['id', ''],
                               :op => {"id" => '~'},
                               :v => {"id" => [question]})
      else
        index_without_multiple_id
      end
    end
  end
end

SearchController.send(:include, SearchControllerPatch)

