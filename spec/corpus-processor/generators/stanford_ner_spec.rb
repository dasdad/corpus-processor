require 'spec_helper'

describe CorpusProcessor::Generators::StanfordNer do
  subject(:stanford_ner) { CorpusProcessor::Generators::StanfordNer.new }

  describe '#generate' do
    subject { stanford_ner.generate(tokens) }

    context 'no tokens' do
      let(:tokens) { [] }

      it { should == "\n" }
    end

    context 'one token' do
      let(:tokens) { [CorpusProcessor::Token.new('banana')] }

      it { should == "banana\tO\n" }
    end

    context 'two tokens' do
      let(:tokens) { [
        CorpusProcessor::Token.new('good'),
        CorpusProcessor::Token.new('banana'),
      ] }

      it { should == "good\tO\nbanana\tO\n" }
    end

    context 'with category' do
      let(:tokens) { [CorpusProcessor::Token.new('Leandro', :person)] }

      it { should == "Leandro\tPERSON\n" }
    end

    context 'with non-default categories' do
      let(:stanford_ner) { CorpusProcessor::Generators::StanfordNer.new(
        banana: 'BANANA'
      ) }

      let(:tokens) { [CorpusProcessor::Token.new('Nanica', :banana)] }

      it { should == "Nanica\tBANANA\n" }
    end
  end
end
