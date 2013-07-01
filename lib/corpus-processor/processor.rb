class CorpusProcessor::Processor
  def initialize(
    parser:     CorpusProcessor::Parsers::Lampada.new,
    generator:  CorpusProcessor::Generators::StanfordNer.new)
    @parser    = parser
    @generator = generator
  end

  def process corpus
    @generator.generate(@parser.parse(corpus))
  end
end
