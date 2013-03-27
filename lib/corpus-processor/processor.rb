module CorpusProcessor
  class Processor

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

    def initialize(categories = Corpus::Categories::INPUT,
                   token_formatter = Corpus::TokenFormatter.new)
      @categories       = categories
      @token_formatter  = token_formatter
    end

    def process(corpus)
      join(
        [].tap { |tokens|
          traverse_with_regexp(join_lines(corpus), CATEGORY_REGEX) do |match|
            text_to_tokenize, category = case match
                                         when String
                                           [match, nil]
                                         when MatchData
                                           [
                                             match[:inner_text],
                                             extract_category(match[:categories])
                                           ]
                                         end
            tokens.push(*tokenize(text_to_tokenize, category))
          end
        }
      )
    end

    def strip_tags(text)
      text.gsub(/<.*?>/, ' ').strip
    end

    def tokenize(text, category = nil)
      strip_tags(text)
        .gsub(/[[:punct:]]/, '')
        .strip
        .split(/\s+/)
        .map { |word| Token.new(word, category) }
    end

    def join(tokens)
      tokens.map { |token| @token_formatter.format(token) }.join("\n") + "\n"
    end

    def join_lines(text)
      text.gsub(/\s+/, ' ').strip
    end

    def traverse_with_regexp(text, regexp)
      if block_given?
        remaining_search = text
        until remaining_search.empty?
          match = remaining_search.match(regexp)
          if match.nil?
            yield remaining_search unless remaining_search.empty?
            remaining_search = ''
          else
            before           = remaining_search[0...match.begin(0)]
            remaining_search = remaining_search[match.end(0)..-1]

            yield before unless before.empty?
            yield match
          end
        end
      end
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
