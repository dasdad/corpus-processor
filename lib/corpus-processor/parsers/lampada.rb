module CorpusProcessor::Parsers
  class Lampada

    CATEGORY_REGEX = /
      (?<any_text>           .*?                       ){0}
      (?<entity_attributes>  \s\g<any_text>
        CATEG="\g<categories>"\g<any_text>             ){0}
      (?<entity_opening_tag> <em\g<entity_attributes>> ){0}
      (?<entity_closing_tag> <\/em>                    ){0}

      # groups of interest
      (?<inner_text>         \g<any_text>              ){0}
      (?<categories>         \g<any_text>              ){0}

      \g<entity_opening_tag>\g<inner_text>\g<entity_closing_tag>
    /ix

    def initialize(categories = CorpusProcessor::DEFAULT_CATEGORIES[:input],
                   traverser  = CorpusProcessor::Traverser.new,
                   tokenizer  = CorpusProcessor::Tokenizer.new)
      @categories = categories
      @traverser  = traverser
      @tokenizer  = tokenizer
    end

    def parse(corpus)
      [].tap { |tokens|
        @traverser.traverse(@tokenizer.join_lines(corpus),
                            CATEGORY_REGEX) do |match|
          text_to_tokenize, category = case match
                                       when String
                                         [match, nil]
                                       when MatchData
                                         [
                                           match[:inner_text],
                                           extract_category(match[:categories])
                                         ]
                                       end
          tokens.push(*@tokenizer.tokenize(text_to_tokenize, category))
        end
      }
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
