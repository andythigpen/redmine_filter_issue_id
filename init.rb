require_dependency 'issue_query_patch'
require_dependency 'search_controller_patch'

Redmine::Plugin.register :redmine_filter_issue_id do
  name 'Filter Issue ID plugin'
  author 'Andrew Thigpen'
  description 'Adds the ability to filter the issue list by ID and search for multiple issues via the search box'
  version '0.0.1'
  url 'http://github.com/andythigpen/redmine_filter_issue_id'
  author_url 'http://github.com/andythigpen'
end
