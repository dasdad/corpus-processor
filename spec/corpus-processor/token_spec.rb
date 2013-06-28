require 'spec_helper'

describe CorpusProcessor::Token do
  subject { CorpusProcessor::Token.new }

  describe 'attributes' do
    it 'word' do
      expect(subject).to respond_to(:word)
    end

    it 'category' do
      expect(subject).to respond_to(:category)
    end
  end
end
