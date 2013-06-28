Corpus Processor
================

[![Gem Version][1]](http://badge.fury.io/rb/corpus-processor)
[![Build Status][2]](https://travis-ci.org/dasdad/corpus-processor)
[![Code Climate][3]](https://codeclimate.com/github/dasdad/corpus-processor)

* [Versão em português][4]
* [English version][5]

Versão em português
===================

Corpus Processor é uma ferramenta para trabalhar com [Linguística de
Corpus][6]. Ele converte _corpora_ entre diferentes formatos para serem usados
em ferramentas de Processamento de Linguagem Natural (NLP).

O primeiro propósito do Corpus Processor e seu único recurso implementado
até agora é transformar _corpora_ encontrados na [Linguateca][7] para o
formato usado pelo treinamento do [Stanford NER][8].

[Linguateca][9] é uma fonte de _corpora_ em português.

[Stanford NER][10] é uma implementação de [Reconhecimento de Entidade
Mencionada (NER)][11].

Instalação
----------

Corpus Processor é uma [Ruby][12] [Gem][13]. Para instalar, dada uma
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

Resultados
----------

Para um exemplo de conversão usando o Corpus Processor, veja este [gist][14].

O _corpus_ é do [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][15] e o
treinamento usou o [Stanford NER][16].

**Note** que a transformação do Corpus Processor descarta muita informação do
_corpus_ anotado. Os _corpora_ usados são bastante ricos em anotações e para
tirar completo proveito deles considere usar as ferramentas encontradas na
[Linguateca][17].

Para entender melhor, siga as seguintes referências:

```
Diana Santos. "O modelo semântico usado no Primeiro HAREM". In Diana Santos & Nuno Cardoso (eds.), Reconhecimento de entidades mencionadas em português: Documentação e actas do HAREM, a primeira avaliação conjunta na área. Linguateca, 2007, pp. 43-57.
http://www.linguateca.pt/aval_conjunta/LivroHAREM/Cap04-SantosCardoso2007-Santos.pdf

Diana Santos. "Evaluation in natural language processing". European Summer School on Language, Logic and Information (ESSLLI 2007) (Trinity College, Dublin, Irlanda, 6-17 de Agosto de 2007).
```

Agradecimentos
--------------

* [Time do HAREM / Linguateca][18] pelo _corpus_ com anotações semânticas em
  português.
* *[Time de NLP de Stanford][19]* pela ferramenta [Stanford NER][20].

English version
===============

Corpus Processor is a tool to work with [Corpus Linguistics][21]. It converts
_corpora_ between different formats for use in Natural Language Processing
(NLP) tools.

The first purpose of Corpus Processor and its current only feature is to
transform _corpora_ found in [Linguateca][22] into the format used for training
in [Stanford NER][23].

[Linguateca][24] is an source of _corpora_ in Portuguese.

[Stanford NER][25] is an implementation of [Named Entity Recognition][26].

Installation
------------

Corpus Processor is a [Ruby][27] [Gem][28]. To install it, given a working
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

Results
-------

For an example of converting one _corpus_ with Corpus Processor, refer to this
[gist][29].

The _corpus_ is from [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][30]
and the training used [Stanford NER][31].

**Note** that the transformation performed by Corpus Processor discards lots
of information from the annotated _corpus_. The _corpora_ used in this process
are very rich in annotations, in order to extract all of it consider using one
of the tools found in [Linguateca][32].

Further information about the subject can be found in the following sources:

```
Diana Santos. "O modelo semântico usado no Primeiro HAREM". In Diana Santos & Nuno Cardoso (eds.), Reconhecimento de entidades mencionadas em português: Documentação e actas do HAREM, a primeira avaliação conjunta na área. Linguateca, 2007, pp. 43-57.
http://www.linguateca.pt/aval_conjunta/LivroHAREM/Cap04-SantosCardoso2007-Santos.pdf

Diana Santos. "Evaluation in natural language processing". European Summer School on Language, Logic and Information (ESSLLI 2007) (Trinity College, Dublin, Irlanda, 6-17 de Agosto de 2007).
```

Thanks
------

* [HAREM / Linguateca team][33] for the semantic annotated _corpus_ in
  Portuguese.
* *[Stanford NLP team][34]* for the [Stanford NER][35] tool.

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

* [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][36] Parser.
* [Stanford NER][37] Generator.

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
[4]: #verso-em-portugus
[5]: #english-version
[6]: http://pt.wikipedia.org/wiki/Lingu%C3%ADstica_de_corpus
[7]: http://www.linguateca.pt
[8]: http://nlp.stanford.edu/software/CRF-NER.shtml
[9]: http://www.linguateca.pt
[10]: http://nlp.stanford.edu/software/CRF-NER.shtml
[11]: http://pt.wikipedia.org/wiki/Reconhecimento_de_entidade_mencionada
[12]: http://www.ruby-lang.org/
[13]: http://rubygems.org/
[14]: https://gist.github.com/leafac/5259008
[15]: http://www.linguateca.pt/HAREM/
[16]: http://nlp.stanford.edu/software/CRF-NER.shtml
[17]: http://www.linguateca.pt
[18]: http://www.linguateca.pt/HAREM
[19]: http://www-nlp.stanford.edu/
[20]: http://nlp.stanford.edu/software/CRF-NER.shtml
[21]: http://en.wikipedia.org/wiki/Corpus_linguistics
[22]: http://www.linguateca.pt
[23]: http://nlp.stanford.edu/software/CRF-NER.shtml
[24]: http://www.linguateca.pt
[25]: http://nlp.stanford.edu/software/CRF-NER.shtml
[26]: http://en.wikipedia.org/wiki/Named-entity_recognition
[27]: http://www.ruby-lang.org/
[28]: http://rubygems.org/
[29]: https://gist.github.com/leafac/5259008
[30]: http://www.linguateca.pt/HAREM/
[31]: http://nlp.stanford.edu/software/CRF-NER.shtml
[32]: http://www.linguateca.pt
[33]: http://www.linguateca.pt/HAREM
[34]: http://www-nlp.stanford.edu/
[35]: http://nlp.stanford.edu/software/CRF-NER.shtml
[36]: http://www.linguateca.pt/HAREM/
[37]: http://nlp.stanford.edu/software/CRF-NER.shtml
