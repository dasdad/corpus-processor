# The entry point for processing corpus.
#
# @example Simple use with default configuration.
#   CorpusProcessor::Processor.new.process('<P>Some text</P>')
#   # => "Some\tO\ntext\tO\n.\tO\n""
class CorpusProcessor::Processor

  # @param categories [Hash] the categories extracted with {Categories}.
  # @param parser [#parse] the parser for original corpus.
  # @param generator [#generate] the generator that computes tokens into
  #   the tranformed corpus.
  def initialize(
    categories: CorpusProcessor::Categories.default,
    parser:     CorpusProcessor::Parsers::Lampada.new(categories),
    generator:  CorpusProcessor::Generators::StanfordNer.new(categories))
    @parser    = parser
    @generator = generator
  end

  # Perform the processing of corpus.
  #
  # @return [String] the converted corpus.
  def process corpus
    @generator.generate @parser.parse(corpus)
  end
end
