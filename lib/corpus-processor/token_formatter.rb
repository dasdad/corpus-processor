module CorpusProcessor
  class TokenFormatter

    def initialize(categories = Corpus::Categories::OUTPUT)
      @categories = categories
    end

    def format(token)
      "#{ token.word }	#{ @categories[token.category] }"
    end
  end
end
