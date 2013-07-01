class CorpusProcessor::Generators::StanfordNer
  def initialize categories = CorpusProcessor::Categories.default
    @categories = categories.fetch :output
  end

  def generate tokens
    tokens.map { |token|
      "#{ token.word }\t#{ @categories[token.category] }"
    }.join("\n") + "\n"
  end
end
