require 'spec_helper'

describe CorpusProcessor::Token do
  subject { CorpusProcessor::Token.new }

  it { should respond_to(:word)     }
  it { should respond_to(:category) }
end
