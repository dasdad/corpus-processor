require 'spec_helper'

describe CorpusProcessor::Generators::StanfordNer do
  subject(:stanford_ner) { CorpusProcessor::Generators::StanfordNer.new }

  describe '#generate' do
    subject { stanford_ner.generate(tokens) }

    context 'no tokens' do
      let(:tokens) { [] }

      it 'returns a single new line' do
        should == "\n"
      end
    end

    context 'one token' do
      let(:tokens) { [CorpusProcessor::Token.new('banana')] }

      it 'returns that token' do
        should == "banana\tO\n"
      end
    end

    context 'two tokens' do
      let(:tokens) { [
        CorpusProcessor::Token.new('good'),
        CorpusProcessor::Token.new('banana'),
      ] }

      it 'returns both tokens in separate lines' do
        should == "good\tO\nbanana\tO\n"
      end
    end

    context 'with category' do
      let(:tokens) { [CorpusProcessor::Token.new('Leandro', :person)] }

      it 'returns that token with right category' do
        should == "Leandro\tPERSON\n"
      end
    end

    context 'with non-default categories' do
      let(:stanford_ner) {
        CorpusProcessor::Generators::StanfordNer.new(banana: 'BANANA')
      }

      let(:tokens) { [CorpusProcessor::Token.new('Nanica', :banana)] }

      it 'uses those categories' do
        should == "Nanica\tBANANA\n"
      end
    end
  end
end
