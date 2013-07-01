require 'spec_helper'

describe CorpusProcessor::Processor do
  subject(:processor) {
    CorpusProcessor::Processor.new parser: parser, generator: generator
  }

  describe '#process' do
    subject { processor.process(corpus) }

    let(:corpus) { 'Some corpus' }
    let(:processed_corpus) {
<<-CORPUS
Some\tO
corpus\tO
CORPUS
    }
    let(:tokens) {
      [
        CorpusProcessor::Token.new('Some'),
        CorpusProcessor::Token.new('corpus'),
      ]
    }
    let(:parser)    { double :parser    }
    let(:generator) { double :generator }

    it 'uses parser and generator to process corpus' do
      expect(parser).to receive(:parse).with(corpus).and_return(tokens)

      expect(generator).to receive(:generate).with(tokens)
                                             .and_return(processed_corpus)

      expect(subject).to eq(processed_corpus)
    end
  end
end
