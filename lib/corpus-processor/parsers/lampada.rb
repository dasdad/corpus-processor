module CorpusProcessor::Parsers
  class Lampada
    def initialize(categories = CorpusProcessor::DEFAULT_CATEGORIES[:input])
      @categories = categories
    end

    def parse(corpus)
      tokens     = []
      document   = Nokogiri::XML(corpus)
      paragraphs = document.css('P')
      punct      = /[[:punct:]]/

      paragraphs.each do |paragraph|
        words = paragraph.text.gsub(punct, ' \1').split(/\s+/)
        words << '.' if ! words.empty? && words.last !~ punct
        words.each do |word|
          tokens << CorpusProcessor::Token.new(word)
        end
      end

      tokens
    end

    def extract_category(categories)
      categories
        .split('|')
        .map { |category_string| @categories[category_string] }
        .compact
        .first
    end
  end
end
