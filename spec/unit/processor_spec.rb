require 'spec_helper'

describe Corpus::Processor do
  subject(:processor) { Corpus::Processor.new }

  describe '#initialize' do
    it 'should recieve categories hash as an optional parameter' do
      Corpus::Processor.new(
        'PESSOA'      => :person,
        'LOCAL'       => :location,
        'ORGANIZACAO' => :organization,
      )
    end
  end

  describe '#process' do
    subject { processor.process(corpus) }

    context 'default categories' do
      context 'empty corpus' do
        let(:corpus) { '' }

        it { should == "\n" }
      end

      context 'doctype' do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
CORPUS
        }

        it { should == "\n" }
      end

      context 'simple phrase' do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
<DOC DOCID="H2-dftre765">
  <P>Fatores Demográficos e Econômicos Subjacentes</P>
</DOC>
</colHAREM>
CORPUS
        }

        it { should ==
<<-EXPECTED
Fatores	O
Demográficos	O
e	O
Econômicos	O
Subjacentes	O
EXPECTED
        }
      end

      context 'two simple phrases' do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
<DOC DOCID="H2-dftre765">
  <P>Fatores Demográficos e Econômicos Subjacentes</P>
  <P>Fatores Demográficos e Econômicos Subjacentes</P>
</DOC>
</colHAREM>
CORPUS
        }

        it { should ==
<<-EXPECTED
Fatores	O
Demográficos	O
e	O
Econômicos	O
Subjacentes	O
Fatores	O
Demográficos	O
e	O
Econômicos	O
Subjacentes	O
EXPECTED
        }
      end

      context 'useless entity' do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
<DOC DOCID="H2-dftre765">
  <P>Nos finais da <EM ID="H2-dftre765-102" CATEG="OUTRO" COMENT="DUVIDA_DIRECTIVASTEMPO">Idade Média</EM></P>
</DOC>
</colHAREM>
CORPUS
        }

        it { should ==
<<-EXPECTED
Nos	O
finais	O
da	O
Idade	O
Média	O
EXPECTED
        }
      end

      context 'one entity' do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
  <DOC DOCID="H2-dftre765">
      <P>Foram igualmente determinantes para evitar que as ideias reformadoras encontrassem divulgação em
      <EM ID="H2-dftre765-23" CATEG="LOCAL" TIPO="HUMANO" SUBTIPO="PAIS" COREL="H2-dftre765-8 H2-dftre765-37" TIPOREL="local_nascimento_de incluido">Portugal</EM>
      </P>
  </DOC>
</colHAREM>
CORPUS
        }

        it { should ==
<<-EXPECTED
Foram	O
igualmente	O
determinantes	O
para	O
evitar	O
que	O
as	O
ideias	O
reformadoras	O
encontrassem	O
divulgação	O
em	O
Portugal	LOCATION
EXPECTED
        }
      end

      context 'multiple entities' do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
  <DOC DOCID="H2-dftre765">
      <P>
      A imprensa, inventada na
      <EM ID="H2-dftre765-9" CATEG="LOCAL" TIPO="HUMANO" SUBTIPO="PAIS" COREL="H2-dftre765-37" TIPOREL="incluido">Alemanha</EM>
      por
      <EM ID="H2-dftre765-10" CATEG="PESSOA" TIPO="INDIVIDUAL" COREL="H2-dftre765-9" TIPOREL="natural_de">John Gutenberg</EM>
      <EM ID="H2-dftre765-20" CATEG="ORGANIZACAO" TIPO="INSTITUICAO" COMENT="2/3">Inquisição</EM>
      e a censura 
      </P>
  </DOC>
</colHAREM>
CORPUS
        }

        it { should ==
<<-EXPECTED
A	O
imprensa	O
inventada	O
na	O
Alemanha	LOCATION
por	O
John	PERSON
Gutenberg	PERSON
Inquisição	ORGANIZATION
e	O
a	O
censura	O
EXPECTED
        }
      end

      context 'spaces after ponctuation' do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
  <DOC DOCID="H2-dftre765">
      <EM ID="H2-dftre765-1" CATEG="ABSTRACCAO|ACONTECIMENTO" TIPO="IDEIA|EFEMERIDE">Reforma Protestante</EM>
      . No
  </DOC>
</colHAREM>
CORPUS
        }

        it { should ==
<<-EXPECTED
Reforma	O
Protestante	O
No	O
EXPECTED
        }
      end
    end

    context 'user-defined categories' do
      let(:processor) {
        Corpus::Processor.new(
          {
            'FRUTA' => :fruit,
            'LIVRO' => :book,
          },
          Corpus::TokenFormatter.new(
            Hash.new('BANANA').merge(
              fruit: 'FRUIT',
              book:  'BOOK',)))
      }

      context 'multiple entities' do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
  <DOC DOCID="H2-dftre765">
      <P>
      A imprensa, inventada na
      <EM ID="H2-dftre765-9" CATEG="FRUTA" TIPO="HUMANO" SUBTIPO="PAIS" COREL="H2-dftre765-37" TIPOREL="incluido">Banana</EM>
      por
      <EM ID="H2-dftre765-10" CATEG="LIVRO" TIPO="INDIVIDUAL" COREL="H2-dftre765-9" TIPOREL="natural_de">Harry Potter</EM>
      <EM ID="H2-dftre765-20" CATEG="ORGANIZACAO" TIPO="INSTITUICAO" COMENT="2/3">Inquisição</EM>
      e a censura 
      </P>
  </DOC>
</colHAREM>
CORPUS
        }

        it { should ==
<<-EXPECTED
A	BANANA
imprensa	BANANA
inventada	BANANA
na	BANANA
Banana	FRUIT
por	BANANA
Harry	BOOK
Potter	BOOK
Inquisição	BANANA
e	BANANA
a	BANANA
censura	BANANA
EXPECTED
        }
      end

    end
  end

  describe '#strip_tags' do
    subject { processor.strip_tags(text) }

    context 'empty text' do
      let(:text) { '' }

      it { should == '' }
    end

    context 'self closed tag' do
      let(:text) { '<br/>' }

      it { should == '' }
    end

    context 'tag with content' do
      let(:text) { '<p>Some text</p>' }

      it { should == 'Some text' }
    end

    context 'content after tag' do
      let(:text) { '<p>Some<br/>text</p>' }

      it { should == 'Some text' }
    end
  end

  describe '#tokenize' do
    subject { processor.tokenize(text, category) }

    let(:category) { nil }

    context 'empty string' do
      let(:text) { '' }

      it { should == [] }
    end

    context 'one word' do
      let(:text) { 'banana' }

      it { should == [Corpus::Token.new('banana')] }
    end

    context 'two words' do
      let(:text) { 'good banana' }

      it { should == [
        Corpus::Token.new('good'),
        Corpus::Token.new('banana'),
      ] }
    end

    context 'ponctuation' do
      let(:text) { 'good, banana' }

      it { should == [
        Corpus::Token.new('good'),
        Corpus::Token.new('banana'),
      ] }
    end

    context 'default category' do
      let(:text)     { 'Google' }
      let(:category) { :organization }

      it { should == [
        Corpus::Token.new('Google', :organization),
      ] }
    end

    context 'with tags' do
      let(:text) { 'good<lalala/>, banana' }

      it { should == [
        Corpus::Token.new('good'),
        Corpus::Token.new('banana'),
      ] }
    end
  end

  describe '#join' do
    subject { processor.join(tokens) }

    context 'no tokens' do
      let(:tokens) { [] }

      it { should == "\n" }
    end

    context 'one token' do
      let(:tokens) { [Corpus::Token.new('banana')] }

      it { should == "banana	O\n" }
    end

    context 'two tokens' do
      let(:tokens) { [
        Corpus::Token.new('good'),
        Corpus::Token.new('banana'),
      ] }

      it { should == "good	O\nbanana	O\n" }
    end
  end

  describe '#join_lines' do
    subject { processor.join_lines(text) }

    context 'empty text' do
      let(:text) { '' }

      it { should == '' }
    end

    context 'one word' do
      let(:text) { 'banana' }

      it { should == 'banana' }
    end

    context 'two lines' do
      let(:text) { "banana\nquiabo" }

      it { should == 'banana quiabo' }
    end

    context 'line with empty space' do
      let(:text) { "banana\n   \nquiabo" }

      it { should == 'banana quiabo' }
    end

    context 'leading spaces' do
      let(:text) { "  \n  banana\n   \nquiabo  \n" }

      it { should == 'banana quiabo' }
    end
  end

  describe '#traverse_with_regexp' do
    subject { processor.traverse_with_regexp(text, regexp) }

    context 'empty text' do
      let(:text)   { '' }
      let(:regexp) { // }

      specify {
        expect { |mock_block|
          processor.traverse_with_regexp(text, regexp, &mock_block)
        }.not_to yield_control
      }
    end

    context 'simple text' do
      let(:text)   { 'abc' }
      let(:regexp) { /b/ }

      specify {
        expect { |mock_block|
          processor.traverse_with_regexp(text, regexp, &mock_block)
        }.to yield_successive_args 'a', text.match(regexp), 'c'
      }
    end

    context 'two matches' do
      let(:text)   { 'abcbd' }
      let(:regexp) { /b/ }

      specify {
        expect { |mock_block|
          processor.traverse_with_regexp(text, regexp, &mock_block)
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
          processor.traverse_with_regexp(text, regexp, &mock_block)
        }.to yield_successive_args text.match(regexp), 'c'
      }
    end

    context 'match in ending' do
      let(:text)   { 'bc' }
      let(:regexp) { /c/ }

      specify {
        expect { |mock_block|
          processor.traverse_with_regexp(text, regexp, &mock_block)
        }.to yield_successive_args 'b', text.match(regexp)
      }
    end
  end

  describe 'extract_category' do
    subject { processor.extract_category(categories) }

    context 'empty categories' do
      let(:categories) { '' }

      it { should == nil }
    end

    context 'one category' do
      let(:categories) { 'PESSOA' }

      it { should == :person }
    end

    context 'two categories' do
      let(:categories) { 'OUTRA|ORGANIZACAO' }

      it { should == :organization }
    end

    context 'ambiguidade' do
      let(:categories) { 'PESSOA|ORGANIZACAO' }

      it { should == :person }
    end
  end
end
