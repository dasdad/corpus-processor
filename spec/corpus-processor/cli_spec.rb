require 'spec_helper'

require 'corpus-processor/cli'

describe CorpusProcessor::Cli do
  subject(:cli) { CorpusProcessor::Cli.new }

  let(:input_file)  { STDIN  }
  let(:output_file) { STDOUT }

  describe '#process' do
    subject { cli.process }

    before do
      expect(input_file).to receive(:read)
        .and_return(<<-INPUT.encode('ISO-8859-1'))
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE colHAREM>
<colHAREM versao="Segundo_dourada_com_relacoes_14Abril2010">
  <DOC DOCID="H2-dftre765">
    <P>Fatores Demográficos e Econômicos Subjacentes</P>
    <P>
      A revolta histórica produz normalmente uma nova forma de pensamento quanto à forma de organização da sociedade. Assim foi com a
      <EM ID="H2-dftre765-1" CATEG="ABSTRACCAO|ACONTECIMENTO" TIPO="IDEIA|EFEMERIDE">Reforma Protestante</EM>
      . No seguimento do colapso de instituições monásticas e do escolasticismo
      nos finais da <EM ID="H2-dftre765-102" CATEG="OUTRO" COMENT="DUVIDA_DIRECTIVASTEMPO">Idade Média</EM>
      na
      <EM ID="H2-dftre765-37" CATEG="LOCAL" TIPO="HUMANO" SUBTIPO="DIVISAO">Europa</EM>
      , acentuado pela "
<OMITIDO>      <EM ID="H2-dftre765-17" CATEG="ACONTECIMENTO" TIPO="EFEMERIDE">Cativeiro Babilónica da igreja</EM></OMITIDO>
      "
      no papado de <EM ID="H2-dftre765-11" CATEG="ACONTECIMENTO" TIPO="EVENTO">Avignon</EM>
      , o
INPUT

      expect(output_file).to receive(:puts).with(<<-OUTPUT)
Fatores\tO
Demográficos\tO
e\tO
Econômicos\tO
Subjacentes\tO
.\tO
A\tO
revolta\tO
histórica\tO
produz\tO
normalmente\tO
uma\tO
nova\tO
forma\tO
de\tO
pensamento\tO
quanto\tO
à\tO
forma\tO
de\tO
organização\tO
da\tO
sociedade\tO
.\tO
Assim\tO
foi\tO
com\tO
a\tO
Reforma\tO
Protestante\tO
.\tO
No\tO
seguimento\tO
do\tO
colapso\tO
de\tO
instituições\tO
monásticas\tO
e\tO
do\tO
escolasticismo\tO
nos\tO
finais\tO
da\tO
Idade\tO
Média\tO
na\tO
Europa\tLOCATION
,\tO
acentuado\tO
pela\tO
"\tO
Cativeiro\tO
Babilónica\tO
da\tO
igreja\tO
"\tO
no\tO
papado\tO
de\tO
Avignon\tO
,\tO
o\tO
.\tO
OUTPUT

      expect(output_file).to receive(:close)
    end

    it 'processes the corpus' do
      subject
    end
  end
end
