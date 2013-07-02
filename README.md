Corpus Processor
================

[![Gem Version][1]](http://badge.fury.io/rb/corpus-processor)
[![Build Status][2]](https://travis-ci.org/dasdad/corpus-processor)
[![Code Climate][3]](https://codeclimate.com/github/dasdad/corpus-processor)
[![Dependency Status][4]](https://gemnasium.com/dasdad/corpus-processor)
[![Coverage Status][5]](https://coveralls.io/r/dasdad/corpus-processor)

* [Versão em português][6]
* [English version][7]

Versão em português
===================

Corpus Processor é uma ferramenta para trabalhar com [Linguística de
Corpus][8]. Ele converte _corpora_ entre diferentes formatos para serem usados
em ferramentas de Processamento de Linguagem Natural (NLP).

O primeiro propósito do Corpus Processor e seu único recurso implementado
até agora é transformar _corpora_ encontrados na [Linguateca][9] para o
formato usado pelo treinamento do [Stanford NER][10].

[Linguateca][11] é uma fonte de _corpora_ em português.

[Stanford NER][12] é uma implementação de [Reconhecimento de Entidade
Mencionada (NER)][13].

Instalação
----------

Corpus Processor é uma [Ruby][14] [Gem][15]. Para instalar, dada uma
instalação de Ruby, rode:

```bash
$ gem install corpus_processor
```

Uso
---

Converter _corpus_ do formato do LâMPADA 2.0 para o formato do Stanford-NER:

```bash
$ corpus-processor process [INPUT_FILE [OUTPUT_FILE]]
```

As classes reconhecidas por padrão pelo Corpus Processor são `PESSOA`, `LOCAL`
e `ORGANIZACAO`. Para configurar outras classes, veja o arquivo de configuração
em `lib/corpus-processor/categories/default.yml`.

Para usar outras configurações, veja as opções com:

```bash
$ corpus-processor help process
```

Resultados
----------

Para um exemplo de conversão usando o Corpus Processor, veja este [gist][16].

O _corpus_ é do [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][17] e o
treinamento usou o [Stanford NER][18].

**Note** que a transformação do Corpus Processor descarta muita informação do
_corpus_ anotado. Os _corpora_ usados são bastante ricos em anotações e para
tirar completo proveito deles considere usar as ferramentas encontradas na
[Linguateca][19].

Para entender melhor, siga as seguintes referências:

```
Diana Santos. "O modelo semântico usado no Primeiro HAREM". In Diana Santos & Nuno Cardoso (eds.), Reconhecimento de entidades mencionadas em português: Documentação e actas do HAREM, a primeira avaliação conjunta na área. Linguateca, 2007, pp. 43-57.
http://www.linguateca.pt/aval_conjunta/LivroHAREM/Cap04-SantosCardoso2007-Santos.pdf

Diana Santos. "Evaluation in natural language processing". European Summer School on Language, Logic and Information (ESSLLI 2007) (Trinity College, Dublin, Irlanda, 6-17 de Agosto de 2007).
```

Agradecimentos
--------------

* [Time do HAREM / Linguateca][20] pelo _corpus_ com anotações semânticas em
  português.
* *[Time de NLP de Stanford][21]* pela ferramenta [Stanford NER][22].

English version
===============

Corpus Processor is a tool to work with [Corpus Linguistics][23]. It converts
_corpora_ between different formats for use in Natural Language Processing
(NLP) tools.

The first purpose of Corpus Processor and its current only feature is to
transform _corpora_ found in [Linguateca][24] into the format used for training
in [Stanford NER][25].

[Linguateca][26] is an source of _corpora_ in Portuguese.

[Stanford NER][27] is an implementation of [Named Entity Recognition][28].

Installation
------------

Corpus Processor is a [Ruby][29] [Gem][30]. To install it, given a working
installation of Ruby, run:

```bash
$ gem install corpus_processor
```

Usage
-----

Convert _corpus_ from LâMPADA 2.0 format to Stanford-NER format:

```bash
$ corpus-processor process [INPUT_FILE [OUTPUT_FILE]]
```

Classes recognized by default in Corpus Processor are `PESSOA` (person),
`LOCAL` (location) and `ORGANIZACAO` (organization). In order to configure
other classes, refer to `lib/corpus-processor/categories/default.yml`.

To run with different configurations, consult the options with:

```bash
$ corpus-processor help process
```

Results
-------

For an example of converting one _corpus_ with Corpus Processor, refer to this
[gist][31].

The _corpus_ is from [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][32]
and the training used [Stanford NER][33].

**Note** that the transformation performed by Corpus Processor discards lots
of information from the annotated _corpus_. The _corpora_ used in this process
are very rich in annotations, in order to extract all of it consider using one
of the tools found in [Linguateca][34].

Further information about the subject can be found in the following sources:

```
Diana Santos. "O modelo semântico usado no Primeiro HAREM". In Diana Santos & Nuno Cardoso (eds.), Reconhecimento de entidades mencionadas em português: Documentação e actas do HAREM, a primeira avaliação conjunta na área. Linguateca, 2007, pp. 43-57.
http://www.linguateca.pt/aval_conjunta/LivroHAREM/Cap04-SantosCardoso2007-Santos.pdf

Diana Santos. "Evaluation in natural language processing". European Summer School on Language, Logic and Information (ESSLLI 2007) (Trinity College, Dublin, Irlanda, 6-17 de Agosto de 2007).
```

Thanks
------

* [HAREM / Linguateca team][35] for the semantic annotated _corpus_ in
  Portuguese.
* *[Stanford NLP team][36]* for the [Stanford NER][37] tool.

Contributing
------------

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.

Changelog
---------

### 0.2.0

* Renamed Harem to LâMPADA, as asked by Linguateca's team.

### 0.0.1

* [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][38] Parser.
* [Stanford NER][39] Generator.

License
-------

Copyright (c) 2013 Das Dad

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[1]: https://fury-badge.herokuapp.com/rb/corpus-processor.png
[2]: https://travis-ci.org/dasdad/corpus-processor.png
[3]: https://codeclimate.com/github/dasdad/corpus-processor.png
[4]: https://gemnasium.com/dasdad/corpus-processor.png
[5]: https://coveralls.io/repos/dasdad/corpus-processor/badge.png
[6]: #verso-em-portugus
[7]: #english-version
[8]: http://pt.wikipedia.org/wiki/Lingu%C3%ADstica_de_corpus
[9]: http://www.linguateca.pt
[10]: http://nlp.stanford.edu/software/CRF-NER.shtml
[11]: http://www.linguateca.pt
[12]: http://nlp.stanford.edu/software/CRF-NER.shtml
[13]: http://pt.wikipedia.org/wiki/Reconhecimento_de_entidade_mencionada
[14]: http://www.ruby-lang.org/
[15]: http://rubygems.org/
[16]: https://gist.github.com/leafac/5259008
[17]: http://www.linguateca.pt/HAREM/
[18]: http://nlp.stanford.edu/software/CRF-NER.shtml
[19]: http://www.linguateca.pt
[20]: http://www.linguateca.pt/HAREM
[21]: http://www-nlp.stanford.edu/
[22]: http://nlp.stanford.edu/software/CRF-NER.shtml
[23]: http://en.wikipedia.org/wiki/Corpus_linguistics
[24]: http://www.linguateca.pt
[25]: http://nlp.stanford.edu/software/CRF-NER.shtml
[26]: http://www.linguateca.pt
[27]: http://nlp.stanford.edu/software/CRF-NER.shtml
[28]: http://en.wikipedia.org/wiki/Named-entity_recognition
[29]: http://www.ruby-lang.org/
[30]: http://rubygems.org/
[31]: https://gist.github.com/leafac/5259008
[32]: http://www.linguateca.pt/HAREM/
[33]: http://nlp.stanford.edu/software/CRF-NER.shtml
[34]: http://www.linguateca.pt
[35]: http://www.linguateca.pt/HAREM
[36]: http://www-nlp.stanford.edu/
[37]: http://nlp.stanford.edu/software/CRF-NER.shtml
[38]: http://www.linguateca.pt/HAREM/
[39]: http://nlp.stanford.edu/software/CRF-NER.shtml
