require 'spec_helper'

describe CorpusProcessor::Parsers::Lampada do
  subject(:lampada) { CorpusProcessor::Parsers::Lampada.new }

  describe '#parse' do
    subject { lampada.parse(corpus) }

    context 'default categories' do
      context 'empty corpus' do
        let(:corpus) { '' }

        it 'returns an empty list' do
          expect(subject).to eq([])
        end
      end

      context 'doctype' do
        let(:corpus) {
<<-CORPUS.encode('ISO-8859-1')
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
CORPUS
        }

        it 'returns an empty list' do
          expect(subject).to eq([])
        end
      end

      context 'simple phrase' do
        let(:corpus) {
<<-CORPUS.encode('ISO-8859-1')
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
<DOC DOCID="H2-dftre765">
  <P>Fatores Demográficos e Econômicos Subjacentes.</P>
</DOC>
</colHAREM>
CORPUS
        }

        it 'tokenizes the phrase' do
          expect(subject).to eq([
            CorpusProcessor::Token.new('Fatores'),
            CorpusProcessor::Token.new('Demográficos'),
            CorpusProcessor::Token.new('e'),
            CorpusProcessor::Token.new('Econômicos'),
            CorpusProcessor::Token.new('Subjacentes'),
            CorpusProcessor::Token.new('.'),
          ])
        end
      end

      context 'two simple phrases' do
        let(:corpus) {
<<-CORPUS.encode('ISO-8859-1')
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

        it 'tokenizes the phrase and appends periods where needed' do
          expect(subject).to eq([
            CorpusProcessor::Token.new('Fatores'),
            CorpusProcessor::Token.new('Demográficos'),
            CorpusProcessor::Token.new('e'),
            CorpusProcessor::Token.new('Econômicos'),
            CorpusProcessor::Token.new('Subjacentes'),
            CorpusProcessor::Token.new('.'),
            CorpusProcessor::Token.new('Fatores'),
            CorpusProcessor::Token.new('Demográficos'),
            CorpusProcessor::Token.new('e'),
            CorpusProcessor::Token.new('Econômicos'),
            CorpusProcessor::Token.new('Subjacentes'),
            CorpusProcessor::Token.new('.'),
          ])
        end
      end

      context 'useless entity' do
        let(:corpus) {
<<-CORPUS.encode('ISO-8859-1')
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
<DOC DOCID="H2-dftre765">
  <P>Nos finais da <EM ID="H2-dftre765-102" CATEG="OUTRO" COMENT="DUVIDA_DIRECTIVASTEMPO">Idade Média</EM></P>
</DOC>
</colHAREM>
CORPUS
        }

        it 'ignores that entity' do
          expect(subject).to eq([
            CorpusProcessor::Token.new('Nos'),
            CorpusProcessor::Token.new('finais'),
            CorpusProcessor::Token.new('da'),
            CorpusProcessor::Token.new('Idade'),
            CorpusProcessor::Token.new('Média'),
            CorpusProcessor::Token.new('.'),
          ])
        end
      end

      context 'one relevant entity' do
        let(:corpus) {
<<-CORPUS.encode('ISO-8859-1')
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

        it 'finds that entity' do
          expect(subject).to eq([
            CorpusProcessor::Token.new('Foram'),
            CorpusProcessor::Token.new('igualmente'),
            CorpusProcessor::Token.new('determinantes'),
            CorpusProcessor::Token.new('para'),
            CorpusProcessor::Token.new('evitar'),
            CorpusProcessor::Token.new('que'),
            CorpusProcessor::Token.new('as'),
            CorpusProcessor::Token.new('ideias'),
            CorpusProcessor::Token.new('reformadoras'),
            CorpusProcessor::Token.new('encontrassem'),
            CorpusProcessor::Token.new('divulgação'),
            CorpusProcessor::Token.new('em'),
            CorpusProcessor::Token.new('Portugal', :location),
            CorpusProcessor::Token.new('.'),
          ])
        end
      end

      context 'multiple relevant entities' do
        let(:corpus) {
<<-CORPUS.encode('ISO-8859-1')
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

        it 'finds all of them' do
          expect(subject).to eq([
            CorpusProcessor::Token.new('A'),
            CorpusProcessor::Token.new('imprensa'),
            CorpusProcessor::Token.new(','),
            CorpusProcessor::Token.new('inventada'),
            CorpusProcessor::Token.new('na'),
            CorpusProcessor::Token.new('Alemanha', :location),
            CorpusProcessor::Token.new('por'),
            CorpusProcessor::Token.new('John', :person),
            CorpusProcessor::Token.new('Gutenberg', :person),
            CorpusProcessor::Token.new('Inquisição', :organization),
            CorpusProcessor::Token.new('e'),
            CorpusProcessor::Token.new('a'),
            CorpusProcessor::Token.new('censura'),
            CorpusProcessor::Token.new('.'),
          ])
        end
      end

      context 'alternative tags' do
        context 'all options are unknown categories' do
          let(:corpus) {
  <<-CORPUS.encode('ISO-8859-1')
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
  <DOC DOCID="H2-dftre765">
      <P>
      <ALT> <EM ID="H2-dftre765-12aa" CATEG="OBRA" TIPO="REPRODUZIDA">95 Teses de Martinho Lutero</EM> |
    <EM ID="H2-dftre765-12" CATEG="OBRA" TIPO="REPRODUZIDA" SUBTIPO="LIVRO">95 Teses</EM>
    de
    <EM ID="H2-dftre765-13" CATEG="SER-HUMANO" TIPO="INDIVIDUAL" COREL="H2-dftre765-12 H2-dftre765-9 H2-dftre765-1" TIPOREL="autor_de natural_de PESSOA**participante_em**H2-dftre765-1**ACONTECIMENTO">Martinho Lutero</EM></ALT>
      </P>
  </DOC>
</colHAREM>
CORPUS
          }

          it 'rejects all of them' do
            expect(subject).to eq([
              CorpusProcessor::Token.new('95'),
              CorpusProcessor::Token.new('Teses'),
              CorpusProcessor::Token.new('de'),
              CorpusProcessor::Token.new('Martinho'),
              CorpusProcessor::Token.new('Lutero'),
              CorpusProcessor::Token.new('.'),
            ])
          end
        end

        context 'one of the options has known categories' do
          let(:corpus) {
  <<-CORPUS.encode('ISO-8859-1')
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
  <DOC DOCID="H2-dftre765">
      <P>
      <ALT> <EM ID="H2-dftre765-12aa" CATEG="OBRA" TIPO="REPRODUZIDA">95 Teses de Martinho Lutero</EM> |
    <EM ID="H2-dftre765-12" CATEG="OBRA" TIPO="REPRODUZIDA" SUBTIPO="LIVRO">95 Teses</EM>
    de
    <EM ID="H2-dftre765-13" CATEG="PESSOA" TIPO="INDIVIDUAL" COREL="H2-dftre765-12 H2-dftre765-9 H2-dftre765-1" TIPOREL="autor_de natural_de PESSOA**participante_em**H2-dftre765-1**ACONTECIMENTO">Martinho Lutero</EM></ALT>
      </P>
  </DOC>
</colHAREM>
CORPUS
          }

          it 'prefers that option' do
            expect(subject).to eq([
              CorpusProcessor::Token.new('95'),
              CorpusProcessor::Token.new('Teses'),
              CorpusProcessor::Token.new('de'),
              CorpusProcessor::Token.new('Martinho', :person),
              CorpusProcessor::Token.new('Lutero', :person),
              CorpusProcessor::Token.new('.'),
            ])
          end
        end

        context 'more than one option have known categories' do
          let(:corpus) {
  <<-CORPUS.encode('ISO-8859-1')
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
  <DOC DOCID="H2-dftre765">
      <P>
      <ALT> <EM ID="H2-dftre765-12aa" CATEG="LOCAL" TIPO="REPRODUZIDA">95 Teses de Martinho Lutero</EM> |
    <EM ID="H2-dftre765-12" CATEG="OBRA" TIPO="REPRODUZIDA" SUBTIPO="LIVRO">95 Teses</EM>
    de
    <EM ID="H2-dftre765-13" CATEG="PESSOA" TIPO="INDIVIDUAL" COREL="H2-dftre765-12 H2-dftre765-9 H2-dftre765-1" TIPOREL="autor_de natural_de PESSOA**participante_em**H2-dftre765-1**ACONTECIMENTO">Martinho Lutero</EM></ALT>
      </P>
  </DOC>
</colHAREM>
CORPUS
          }

          it 'prefers the option that covers most text with known ' \
                                                              'categories' do
            expect(subject).to eq([
              CorpusProcessor::Token.new('95', :location),
              CorpusProcessor::Token.new('Teses', :location),
              CorpusProcessor::Token.new('de', :location),
              CorpusProcessor::Token.new('Martinho', :location),
              CorpusProcessor::Token.new('Lutero', :location),
              CorpusProcessor::Token.new('.'),
            ])
          end
        end
      end
    end

    context 'user-defined categories' do
      let(:lampada) {
        CorpusProcessor::Parsers::Lampada.new(
          input: {
            'FRUTA' => :fruit,
            'LIVRO' => :book,
          }
        )
      }

      context 'multiple entities' do
        let(:corpus) {
<<-CORPUS.encode('ISO-8859-1')
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

        it 'finds all of them' do
          expect(subject).to eq([
            CorpusProcessor::Token.new('A'),
            CorpusProcessor::Token.new('imprensa'),
            CorpusProcessor::Token.new(','),
            CorpusProcessor::Token.new('inventada'),
            CorpusProcessor::Token.new('na'),
            CorpusProcessor::Token.new('Banana', :fruit),
            CorpusProcessor::Token.new('por'),
            CorpusProcessor::Token.new('Harry', :book),
            CorpusProcessor::Token.new('Potter', :book),
            CorpusProcessor::Token.new('Inquisição'),
            CorpusProcessor::Token.new('e'),
            CorpusProcessor::Token.new('a'),
            CorpusProcessor::Token.new('censura'),
            CorpusProcessor::Token.new('.'),
          ])
        end
      end
    end
  end
end
