require 'spec_helper'

describe CorpusProcessor::Processor do
  subject(:processor) { CorpusProcessor::Processor.new(parser, generator) }

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

    specify {
      parser.should_receive(:parse)
            .with(corpus)
            .and_return(tokens)

      generator.should_receive(:generate)
            .with(tokens)
            .and_return(processed_corpus)

      subject.should == processed_corpus
    }
  end
end
