require "spec_helper"

describe CorpusProcessor::Generators::StanfordNer do
  subject(:stanford_ner) { CorpusProcessor::Generators::StanfordNer.new }

  describe "#generate" do
    subject { stanford_ner.generate(tokens) }

    context "no tokens" do
      let(:tokens) { [] }

      it { should == "\n" }
    end

    context "one token" do
      let(:tokens) { [CorpusProcessor::Token.new("banana")] }

      it { should == "banana	O\n" }
    end

    context "two tokens" do
      let(:tokens) { [
        CorpusProcessor::Token.new("good"),
        CorpusProcessor::Token.new("banana"),
      ] }

      it { should == "good	O\nbanana	O\n" }
    end

    context "with category" do
      let(:tokens) { [CorpusProcessor::Token.new("Leandro", :person)] }

      it { should == "Leandro	PERSON\n" }
    end

    context "with non-default categories" do
      let(:stanford_ner) { CorpusProcessor::Generators::StanfordNer.new(
        banana: "BANANA"
      ) }

      let(:tokens) { [CorpusProcessor::Token.new("Nanica", :banana)] }

      it { should == "Nanica	BANANA\n" }
    end
  end
end
