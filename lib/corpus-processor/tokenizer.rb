class CorpusProcessor::Tokenizer
  def tokenize(text, category = nil)
    strip_tags(text)
      .gsub(/[[:punct:]]/, '')
      .strip
      .split(/\s+/)
      .map { |word| CorpusProcessor::Token.new(word, category) }
  end

  def strip_tags(text)
    text.gsub(/<.*?>/, ' ').strip
  end

  def join_lines(text)
    text.gsub(/\s+/, ' ').strip
  end
end
