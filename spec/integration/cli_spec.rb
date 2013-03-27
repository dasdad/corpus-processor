require 'spec_helper'

require 'corpus/cli'

describe Corpus::Cli do
  include FakeFS::SpecHelpers
  subject(:cli) { Corpus::Cli.new }

  let(:input_file)  { 'input_file'  }
  let(:output_file) { 'output_file' }

  before do
    File.open(input_file, 'w') { |file|
      file.write(
<<-INPUT
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
      )
    }
  end

  describe '#process' do
    before do
      cli.process(input_file, output_file)
    end

    specify { File.read(output_file).should ==
<<-OUTPUT
Fatores	O
Demográficos	O
e	O
Econômicos	O
Subjacentes	O
A	O
revolta	O
histórica	O
produz	O
normalmente	O
uma	O
nova	O
forma	O
de	O
pensamento	O
quanto	O
à	O
forma	O
de	O
organização	O
da	O
sociedade	O
Assim	O
foi	O
com	O
a	O
Reforma	O
Protestante	O
No	O
seguimento	O
do	O
colapso	O
de	O
instituições	O
monásticas	O
e	O
do	O
escolasticismo	O
nos	O
finais	O
da	O
Idade	O
Média	O
na	O
Europa	LOCATION
acentuado	O
pela	O
Cativeiro	O
Babilónica	O
da	O
igreja	O
no	O
papado	O
de	O
Avignon	O
o	O
OUTPUT
    }
  end
end
