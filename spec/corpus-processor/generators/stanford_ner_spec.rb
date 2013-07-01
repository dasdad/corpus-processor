require 'spec_helper'

describe CorpusProcessor::Generators::StanfordNer do
  subject(:stanford_ner) { CorpusProcessor::Generators::StanfordNer.new }

  describe '#generate' do
    subject { stanford_ner.generate(tokens) }

    context 'no tokens' do
      let(:tokens) { [] }

      it 'returns a single new line' do
        expect(subject).to eq("\n")
      end
    end

    context 'one token' do
      let(:tokens) { [CorpusProcessor::Token.new('banana')] }

      it 'returns that token' do
        expect(subject).to eq("banana\tO\n")
      end
    end

    context 'two tokens' do
      let(:tokens) { [
        CorpusProcessor::Token.new('good'),
        CorpusProcessor::Token.new('banana'),
      ] }

      it 'returns both tokens in separate lines' do
        expect(subject).to eq("good\tO\nbanana\tO\n")
      end
    end

    context 'with category' do
      let(:tokens) { [CorpusProcessor::Token.new('Leandro', :person)] }

      it 'returns that token with right category' do
        expect(subject).to eq("Leandro\tPERSON\n")
      end
    end

    context 'with non-default categories' do
      let(:stanford_ner) {
        CorpusProcessor::Generators::StanfordNer.new(
                                                  output: { banana: 'BANANA' })
      }

      let(:tokens) { [CorpusProcessor::Token.new('Nanica', :banana)] }

      it 'uses those categories' do
        expect(subject).to eq("Nanica\tBANANA\n")
      end
    end
  end
end
