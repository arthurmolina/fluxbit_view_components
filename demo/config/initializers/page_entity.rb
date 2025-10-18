module Lookbook
  class PageEntity < Entity
    def markdown?
      @_markdown ||= fetch_config(:markdown) { file_path.to_s.match?(/(.*)\.md(\..*)?$/) }
    end
  end
end
