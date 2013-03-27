require 'spec_helper'

describe Corpus::Token do
  subject { Corpus::Token.new }

  it { should respond_to(:word)     }
  it { should respond_to(:category) }
end
