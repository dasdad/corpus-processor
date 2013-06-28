require 'spec_helper'

describe CorpusProcessor::Traverser do
  subject(:traverser) { CorpusProcessor::Traverser.new }

  describe '#traverse' do
    subject { traverser.traverse(text, regexp) }

    context 'empty text' do
      let(:text)   { '' }
      let(:regexp) { // }

      specify {
        expect { |mock_block|
          traverser.traverse(text, regexp, &mock_block)
        }.not_to yield_control
      }
    end

    context 'simple text' do
      let(:text)   { 'abc' }
      let(:regexp) { /b/ }

      specify {
        expect { |mock_block|
          traverser.traverse(text, regexp, &mock_block)
        }.to yield_successive_args 'a', text.match(regexp), 'c'
      }
    end

    context 'two matches' do
      let(:text)   { 'abcbd' }
      let(:regexp) { /b/ }

      specify {
        expect { |mock_block|
          traverser.traverse(text, regexp, &mock_block)
        }.to yield_successive_args 'a',
                                   text.match(regexp),
                                   'c',
                                   text[2..-1].match(regexp),
                                   'd'
      }
    end

    context 'match in beginning' do
      let(:text)   { 'bc' }
      let(:regexp) { /b/ }

      specify {
        expect { |mock_block|
          traverser.traverse(text, regexp, &mock_block)
        }.to yield_successive_args text.match(regexp), 'c'
      }
    end

    context 'match in ending' do
      let(:text)   { 'bc' }
      let(:regexp) { /c/ }

      specify {
        expect { |mock_block|
          traverser.traverse(text, regexp, &mock_block)
        }.to yield_successive_args 'b', text.match(regexp)
      }
    end
  end
end
