module CorpusProcessor::Generators
  class StanfordNer
    def initialize(categories = CorpusProcessor::DEFAULT_CATEGORIES[:output])
      @categories = categories
    end

    def generate(tokens)
      tokens.map { |token|
        "#{ token.word }	#{ @categories[token.category] }"
      }.join("\n") + "\n"
    end
  end
end
