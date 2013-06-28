module CorpusProcessor::Parsers
  class Lampada
    def initialize categories_map = CorpusProcessor::DEFAULT_CATEGORIES[:input]
      self.categories_map = categories_map
    end

    def parse corpus
      process_nodes Nokogiri::XML(corpus).css('P')
    end

    protected

      PUNCT        = /[[:punct:]]/
      SPACES       = /\s+/
      PERIOD_TOKEN = CorpusProcessor::Token.new('.')

      attr_accessor :categories_map
      attr_accessor :category

      def process_nodes nodes
        nodes.reduce([]) { |tokens, node| tokens.push(*process_node(node)) }
      end

      def process_node node
        case node
        when Nokogiri::XML::Text    then process_text    node.text
        when Nokogiri::XML::Element then process_element node
        else
          raise ArgumentError, "#{ node } cannot be handled by " \
                               "#{ self.class }. This is probably a bug, "\
                               "please report."
        end
      end

      def process_text text
        text.gsub(PUNCT, ' \0 ')
            .strip
            .split(SPACES)
            .map { |word|
          CorpusProcessor::Token.new(word, category)
        }
      end

      def process_element element
        case element.name
        when 'P'   then process_p     element
        when 'EM'  then process_em    element
        when 'ALT' then process_alt   element
        else            process_nodes element.children
        end
      end

      def process_p p
        tokens = process_nodes p.children
        tokens << PERIOD_TOKEN if ! tokens.empty? && tokens.last.word !~ PUNCT
        tokens
      end

      def process_em em
        categ_attribute = em.attributes['CATEG']
        unless categ_attribute.nil?
          self.category = extract categ_attribute.text
        end
        tokens = process_nodes em.children
        self.category = nil
        tokens
      end

      def process_alt alt
        alternatives  = alt.inner_html.encode('UTF-8').split('|')
        fake_xmls     = alternatives.map { |alternative|
          Nokogiri::XML "<document>#{ alternative }</document>"
        }
        alternatives_tokens = fake_xmls.map { |fake_xml|
          process_nodes fake_xml.children
        }
        alternatives_tokens.max_by { |alternative_tokens|
          alternative_tokens.count { |alternative_token|
            ! alternative_token.category.nil?
          }
        }
      end

      def extract categories
        category = categories.split('|').find { |category|
          categories_map.include? category
        }

        categories_map[category]
      end
  end
end
