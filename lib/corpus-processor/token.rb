# The internal representation of a token.
#
# Tokens are extracted from original corpus and are defined by single words
# or punctuation.
#
# They also contain a category, which is originated form the tagging in the
# corpus.
class CorpusProcessor::Token

  # @return [String] the word from text. It shouldn't contain spaces.
  attr_reader :word

  # @return [Symbol] the type of the {Token}. It should be a valid category
  #   from {Categories}.
  attr_reader :category

  # @param word [String] the word from text. It shouldn't contain spaces.
  # @param category [Symbol] the type of the {Token}. It should be a valid
  #   category from {Categories}.
  def initialize word = '', category = nil
    self.word     = word
    self.category = category
  end

  # Determine equality of two {Token}s.
  #
  # @param other [Token] the other {Token} to test.
  def ==(other)
    word == other.word && category == other.category
  end

  protected

    attr_writer :word
    attr_writer :category
end
