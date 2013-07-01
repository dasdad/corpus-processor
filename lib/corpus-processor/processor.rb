class CorpusProcessor::Processor
  def initialize(
    categories: CorpusProcessor::Categories.default,
    parser:     CorpusProcessor::Parsers::Lampada.new(categories),
    generator:  CorpusProcessor::Generators::StanfordNer.new(categories))
    @parser    = parser
    @generator = generator
  end

  def process corpus
    @generator.generate(@parser.parse(corpus))
  end
end
