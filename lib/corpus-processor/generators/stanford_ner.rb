# The generator for Stanford NER corpus.
#
# Generates corpus in the format used by Stanford NER training.
class CorpusProcessor::Generators::StanfordNer

  # @param categories [Hash] the categories definitions loaded by
  #   {CorpusProcessor::Categories}.
  def initialize categories = CorpusProcessor::Categories.default
    @categories = categories.fetch :output
  end

  # Generate the corpus from tokens.
  #
  # @param tokens [Array<CorpusProcessor::Token>] the tokens from which
  #   the corpus is generated.
  # @return [String] the generated corpus.
  def generate tokens
    tokens.map { |token|
      "#{ token.word }\t#{ @categories[token.category] }"
    }.join("\n") + "\n"
  end
end
