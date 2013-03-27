class CorpusProcessor::Traverser
  def traverse(text, regexp, &block)
    return if block.nil?
    remaining_search = text
    until remaining_search.empty?
      match = remaining_search.match(regexp)
      if match.nil?
        block.call remaining_search unless remaining_search.empty?
        remaining_search = ""
      else
        before           = remaining_search[0...match.begin(0)]
        remaining_search = remaining_search[match.end(0)..-1]

        block.call before unless before.empty?
        block.call match
      end
    end
  end
end
