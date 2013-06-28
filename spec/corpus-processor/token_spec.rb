require 'spec_helper'

describe CorpusProcessor::Token do
  subject { CorpusProcessor::Token.new }

  describe 'attributes' do
    it('word')     { should respond_to(:word)     }
    it('category') { should respond_to(:category) }
  end
end
