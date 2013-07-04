# The parser for the corpus in LâMPADA format.
class CorpusProcessor::Parsers::Lampada

  # @param (see Generators::StanfordNer#initialize)
  def initialize categories = CorpusProcessor::Categories.default
    self.categories = categories.fetch :input
  end

  # Parse the corpus in LâMPADA format.
  #
  # @param corpus [String] the original corpus.
  # @return [Array<CorpusProcessor::Token>] the tokens extracted from corpus.
  def parse corpus
    process_nodes Nokogiri::XML(corpus).css('P')
  end

  protected

    attr_accessor :categories
    attr_accessor :current_category

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
      text.gsub(punct, ' \0 ')
          .strip
          .split(spaces)
          .map { |word|
        CorpusProcessor::Token.new(word, current_category)
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
      tokens << period_token if ! tokens.empty? && tokens.last.word !~ punct
      tokens
    end

    def process_em em
      with_category em.attributes['CATEG'] { process_nodes em.children }
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

    def with_category categories_attribute, &block
      unless categories_attribute.nil?
        self.current_category = extract categories_attribute.text
      end
      tokens = block.call
      self.current_category = nil
      tokens
    end

    def extract categories_string
      category = categories_string.split('|').find { |category_string|
        categories.include? category_string
      }

      categories[category]
    end

    def punct
      /[[:punct:]]/
    end

    def spaces
      /\s+/
    end

    def period_token
      @period_token ||= CorpusProcessor::Token.new('.')
    end
end
