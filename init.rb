require 'redmine'
require_dependency 'search_controller_patch'

#TODO is there a better way to do this?
if (Redmine::VERSION.to_a <=> [2,3]) > 0
  require_dependency 'issue_query_patch'
elsif (Redmine::VERSION.to_a <=> [2,2,3]) >= 0
  require_dependency 'query_patch'
end

Redmine::Plugin.register :redmine_filter_issue_id do
  name 'Filter Issue ID plugin'
  author 'Andrew Thigpen'
  description 'Adds the ability to filter the issue list by ID and search for multiple issues via the search box'
  version '0.0.1'
  url 'http://github.com/andythigpen/redmine_filter_issue_id'
  author_url 'http://github.com/andythigpen'
  requires_redmine :version_or_higher => "2.2.3"
end
