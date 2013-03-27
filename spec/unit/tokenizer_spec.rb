require "spec_helper"

describe CorpusProcessor::Tokenizer do
  subject(:tokenizer) { CorpusProcessor::Tokenizer.new }

  describe "#tokenize" do
    subject { tokenizer.tokenize(text, category) }

    let(:category) { nil }

    context "empty string" do
      let(:text) { "" }

      it { should == [] }
    end

    context "one word" do
      let(:text) { "banana" }

      it { should == [CorpusProcessor::Token.new("banana")] }
    end

    context "two words" do
      let(:text) { "good banana" }

      it { should == [
        CorpusProcessor::Token.new("good"),
        CorpusProcessor::Token.new("banana"),
      ] }
    end

    context "ponctuation" do
      let(:text) { "good, banana" }

      it { should == [
        CorpusProcessor::Token.new("good"),
        CorpusProcessor::Token.new("banana"),
      ] }
    end

    context "default category" do
      let(:text)     { "Google" }
      let(:category) { :organization }

      it { should == [
        CorpusProcessor::Token.new("Google", :organization),
      ] }
    end

    context "with tags" do
      let(:text) { "good<lalala/>, banana" }

      it { should == [
        CorpusProcessor::Token.new("good"),
        CorpusProcessor::Token.new("banana"),
      ] }
    end
  end

  describe "#strip_tags" do
    subject { tokenizer.strip_tags(text) }

    context "empty text" do
      let(:text) { "" }

      it { should == "" }
    end

    context "self closed tag" do
      let(:text) { "<br/>" }

      it { should == "" }
    end

    context "tag with content" do
      let(:text) { "<p>Some text</p>" }

      it { should == "Some text" }
    end

    context "content after tag" do
      let(:text) { "<p>Some<br/>text</p>" }

      it { should == "Some text" }
    end
  end

  describe "#join_lines" do
    subject { tokenizer.join_lines(text) }

    context "empty text" do
      let(:text) { "" }

      it { should == "" }
    end

    context "one word" do
      let(:text) { "banana" }

      it { should == "banana" }
    end

    context "two lines" do
      let(:text) { "banana\nquiabo" }

      it { should == "banana quiabo" }
    end

    context "line with empty space" do
      let(:text) { "banana\n   \nquiabo" }

      it { should == "banana quiabo" }
    end

    context "leading spaces" do
      let(:text) { "  \n  banana\n   \nquiabo  \n" }

      it { should == "banana quiabo" }
    end
  end
end
