class CorpusProcessor::Traverser
  def traverse(text, regexp)
    if block_given?
      remaining_search = text
      until remaining_search.empty?
        match = remaining_search.match(regexp)
        if match.nil?
          yield remaining_search unless remaining_search.empty?
          remaining_search = ''
        else
          before           = remaining_search[0...match.begin(0)]
          remaining_search = remaining_search[match.end(0)..-1]

          yield before unless before.empty?
          yield match
        end
      end
    end
  end
end
