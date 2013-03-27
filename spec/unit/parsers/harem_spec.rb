require "spec_helper"

describe CorpusProcessor::Parsers::Harem do
  subject(:harem) { CorpusProcessor::Parsers::Harem.new }

  describe "#parse" do
    subject { harem.parse(corpus) }

    context "default categories" do
      context "empty corpus" do
        let(:corpus) { "" }

        it { should == [] }
      end

      context "doctype" do
        let(:corpus) {
<<-CORPUS
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
CORPUS
        }

        it { should == [] }
      end

      context "simple phrase" do
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

        it { should == [
            CorpusProcessor::Token.new("Fatores"),
            CorpusProcessor::Token.new("Demográficos"),
            CorpusProcessor::Token.new("e"),
            CorpusProcessor::Token.new("Econômicos"),
            CorpusProcessor::Token.new("Subjacentes"),
          ]
        }
      end

      context "two simple phrases" do
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

        it { should == [
            CorpusProcessor::Token.new("Fatores"),
            CorpusProcessor::Token.new("Demográficos"),
            CorpusProcessor::Token.new("e"),
            CorpusProcessor::Token.new("Econômicos"),
            CorpusProcessor::Token.new("Subjacentes"),
            CorpusProcessor::Token.new("Fatores"),
            CorpusProcessor::Token.new("Demográficos"),
            CorpusProcessor::Token.new("e"),
            CorpusProcessor::Token.new("Econômicos"),
            CorpusProcessor::Token.new("Subjacentes"),
          ]
        }
      end

      context "useless entity" do
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

        it { should == [
            CorpusProcessor::Token.new("Nos"),
            CorpusProcessor::Token.new("finais"),
            CorpusProcessor::Token.new("da"),
            CorpusProcessor::Token.new("Idade"),
            CorpusProcessor::Token.new("Média"),
          ]
        }
      end

      context "one entity" do
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

        it { should == [
            CorpusProcessor::Token.new("Foram"),
            CorpusProcessor::Token.new("igualmente"),
            CorpusProcessor::Token.new("determinantes"),
            CorpusProcessor::Token.new("para"),
            CorpusProcessor::Token.new("evitar"),
            CorpusProcessor::Token.new("que"),
            CorpusProcessor::Token.new("as"),
            CorpusProcessor::Token.new("ideias"),
            CorpusProcessor::Token.new("reformadoras"),
            CorpusProcessor::Token.new("encontrassem"),
            CorpusProcessor::Token.new("divulgação"),
            CorpusProcessor::Token.new("em"),
            CorpusProcessor::Token.new("Portugal", :location),
          ]
        }
      end

      context "multiple entities" do
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

        it { should == [
            CorpusProcessor::Token.new("A"),
            CorpusProcessor::Token.new("imprensa"),
            CorpusProcessor::Token.new("inventada"),
            CorpusProcessor::Token.new("na"),
            CorpusProcessor::Token.new("Alemanha", :location),
            CorpusProcessor::Token.new("por"),
            CorpusProcessor::Token.new("John", :person),
            CorpusProcessor::Token.new("Gutenberg", :person),
            CorpusProcessor::Token.new("Inquisição", :organization),
            CorpusProcessor::Token.new("e"),
            CorpusProcessor::Token.new("a"),
            CorpusProcessor::Token.new("censura"),
          ]
        }
      end

      context "spaces after ponctuation" do
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

        it { should == [
            CorpusProcessor::Token.new("Reforma"),
            CorpusProcessor::Token.new("Protestante"),
            CorpusProcessor::Token.new("No"),
          ]
        }
      end
    end

    context "user-defined categories" do
      let(:harem) {
        CorpusProcessor::Parsers::Harem.new({
          "FRUTA" => :fruit,
          "LIVRO" => :book,
        })
      }

      context "multiple entities" do
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

        it { should == [
            CorpusProcessor::Token.new("A"),
            CorpusProcessor::Token.new("imprensa"),
            CorpusProcessor::Token.new("inventada"),
            CorpusProcessor::Token.new("na"),
            CorpusProcessor::Token.new("Banana", :fruit),
            CorpusProcessor::Token.new("por"),
            CorpusProcessor::Token.new("Harry", :book),
            CorpusProcessor::Token.new("Potter", :book),
            CorpusProcessor::Token.new("Inquisição"),
            CorpusProcessor::Token.new("e"),
            CorpusProcessor::Token.new("a"),
            CorpusProcessor::Token.new("censura"),
          ]
        }
      end
    end
  end


  describe "#strip_tags" do
    subject { harem.strip_tags(text) }

    context "empty text" do
      let(:text) { "" }

      it { should == "" }
    end

    context "self closed tag" do
      let(:text) { "<br/>" }

      it { should == "" }
    end

    context "tag with content" do
      let(:text) { "<p>Some text</p>" }

      it { should == "Some text" }
    end

    context "content after tag" do
      let(:text) { "<p>Some<br/>text</p>" }

      it { should == "Some text" }
    end
  end

  describe "#tokenize" do
    subject { harem.tokenize(text, category) }

    let(:category) { nil }

    context "empty string" do
      let(:text) { "" }

      it { should == [] }
    end

    context "one word" do
      let(:text) { "banana" }

      it { should == [CorpusProcessor::Token.new("banana")] }
    end

    context "two words" do
      let(:text) { "good banana" }

      it { should == [
        CorpusProcessor::Token.new("good"),
        CorpusProcessor::Token.new("banana"),
      ] }
    end

    context "ponctuation" do
      let(:text) { "good, banana" }

      it { should == [
        CorpusProcessor::Token.new("good"),
        CorpusProcessor::Token.new("banana"),
      ] }
    end

    context "default category" do
      let(:text)     { "Google" }
      let(:category) { :organization }

      it { should == [
        CorpusProcessor::Token.new("Google", :organization),
      ] }
    end

    context "with tags" do
      let(:text) { "good<lalala/>, banana" }

      it { should == [
        CorpusProcessor::Token.new("good"),
        CorpusProcessor::Token.new("banana"),
      ] }
    end
  end

  describe "#join_lines" do
    subject { harem.join_lines(text) }

    context "empty text" do
      let(:text) { "" }

      it { should == "" }
    end

    context "one word" do
      let(:text) { "banana" }

      it { should == "banana" }
    end

    context "two lines" do
      let(:text) { "banana\nquiabo" }

      it { should == "banana quiabo" }
    end

    context "line with empty space" do
      let(:text) { "banana\n   \nquiabo" }

      it { should == "banana quiabo" }
    end

    context "leading spaces" do
      let(:text) { "  \n  banana\n   \nquiabo  \n" }

      it { should == "banana quiabo" }
    end
  end

  describe "#extract_category" do
    subject { harem.extract_category(categories) }

    context "empty categories" do
      let(:categories) { "" }

      it { should == nil }
    end

    context "one category" do
      let(:categories) { "PESSOA" }

      it { should == :person }
    end

    context "two categories" do
      let(:categories) { "OUTRA|ORGANIZACAO" }

      it { should == :organization }
    end

    context "ambiguidade" do
      let(:categories) { "PESSOA|ORGANIZACAO" }

      it { should == :person }
    end
  end
end
