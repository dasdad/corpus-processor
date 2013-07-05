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

Os resultados do uso do [Corpus Processor][16] com um _corpus_ do
[LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][17] - disponível na
[Linguateca][20] - estão [neste diretório][19]:

* `ner-pt_br.training.txt`: O _corpus_ da [Linguateca][20] convertido com o
  [Corpus Processor][21] para o formato de treinamento do [Stanford NER][22].
* `ner-pt_br.training-partial.txt`: Os primeiros 95% do _corpus_ em
  `ner-pt_br.training.txt`, usados para o teste de precisão do
  [Stanford NER][23].
* `ner-pt_br.test.txt`: Os últimos 5% do curpus em `ner-pt_br.training.txt`,
  usado para testar o modelo linguístico.
* `ner-pt_br.prop`: O arquivo de propriedados no formato do [Stanford NER][24]
  que é usado para treinar com o `ner-pt_br.training.txt`.
* `ner-pt_br.partial.prop`: O arquivo de propriedados no formato do
  [Stanford NER][25] que é usado para treinar com o
  `ner-pt_br.training-partial.txt`.
* `ner-pt_br.ser.gz`: O modelo linguístico no formato do [Stanford NER][26]
  resultante do treinamento com o `ner-pt_br.training.txt`.
* `ner-pt_br.ser-partial.gz`: O modelo linguístico no formato do
  [Stanford NER][27] resultante do treinamento com o
  `ner-pt_br.training-partial.txt`.

A performance do modelo linguístico testado é:

```
CRFClassifier tagged 4450 words in 1 documents at 3632.65 words per second.
         Entity P       R       F1      TP      FP      FN
       LOCATION 0.5667  0.3953  0.4658  17      13      26
   ORGANIZATION 0.4531  0.2500  0.3222  29      35      87
         PERSON 0.5333  0.7442  0.6214  32      28      11
         Totals 0.5065  0.3861  0.4382  78      76      124
```

Essa performance é ruim se compara com [outros trabalhos][28] sobre o assunto,
mas tem servido aos nossos propósitos. Nós continuaremos tentando melhorar
essa situação.

Sugestões são bem vindas sobre como fazer isso.

---

**Note** que a transformação do Corpus Processor descarta muita informação do
_corpus_ anotado. Os _corpora_ usados são bastante ricos em anotações e para
tirar completo proveito deles considere usar as ferramentas encontradas na
[Linguateca][29].

Para entender melhor, siga as seguintes referências:

```
Diana Santos. "O modelo semântico usado no Primeiro HAREM". In Diana Santos & Nuno Cardoso (eds.), Reconhecimento de entidades mencionadas em português: Documentação e actas do HAREM, a primeira avaliação conjunta na área. Linguateca, 2007, pp. 43-57.
http://www.linguateca.pt/aval_conjunta/LivroHAREM/Cap04-SantosCardoso2007-Santos.pdf

Diana Santos. "Evaluation in natural language processing". European Summer School on Language, Logic and Information (ESSLLI 2007) (Trinity College, Dublin, Irlanda, 6-17 de Agosto de 2007).
```

---

[Leia mais sobre o processo de treinamento][30].


Agradecimentos
--------------

* [Time do HAREM / Linguateca][31] pelo _corpus_ com anotações semânticas em
  português.
* *[Time de NLP de Stanford][32]* pela ferramenta [Stanford NER][33].

English version
===============

Corpus Processor is a tool to work with [Corpus Linguistics][34]. It converts
_corpora_ between different formats for use in Natural Language Processing
(NLP) tools.

The first purpose of Corpus Processor and its current only feature is to
transform _corpora_ found in [Linguateca][35] into the format used for training
in [Stanford NER][36].

[Linguateca][37] is an source of _corpora_ in Portuguese.

[Stanford NER][38] is an implementation of [Named Entity Recognition][39].

Installation
------------

Corpus Processor is a [Ruby][40] [Gem][41]. To install it, given a working
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

The results of using [Corpus Processor][42] with a _corpus_ from
[LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][43] - available in
[Linguateca][20] - [this directory][19]:

* `ner-pt_br.training.txt`: The _corpus_ from [Linguateca][46] converted with
  [Corpus Processor][47] to [Stanford NER][48] training format.
* `ner-pt_br.training-partial.txt`: The first 95% of the _corpus_ in
  `ner-pt_br.training.txt`, used for training [Stanford NER][49] for accuracy
  testing.
* `ner-pt_br.test.txt`: The last 5% of the _corpus_ in
  `ner-pt_br.training.txt`, used to test the language model.
* `ner-pt_br.prop`: The property file in [Stanford NER][50]'s format for
  setting up the training with the whole `ner-pt_br.training.txt`.
* `ner-pt_br.partial.prop`: The property file in [Stanford NER][51]'s format
  for setting up the training with the partial
  `ner-pt_br.training-partial.txt`.
* `ner-pt_br.ser.gz`: The resulting language model for [Stanford NER][52]
  trained with `ner-pt_br.training.txt`.
* `ner-pt_br.ser-partial.gz`: The resulting language model for
  [Stanford NER][53] trained with `ner-pt_br.training-partial.txt`.

The performance of the language model under test is:

```
CRFClassifier tagged 4450 words in 1 documents at 3632.65 words per second.
         Entity P       R       F1      TP      FP      FN
       LOCATION 0.5667  0.3953  0.4658  17      13      26
   ORGANIZATION 0.4531  0.2500  0.3222  29      35      87
         PERSON 0.5333  0.7442  0.6214  32      28      11
         Totals 0.5065  0.3861  0.4382  78      76      124
```

This performance is poor if compared with [other works][54] on the topic,
but it has served well our purposes. We'll keep trying to improve on this.

Suggestions are welcome in this regard.

---

**Note** that the transformation performed by Corpus Processor discards lots
of information from the annotated _corpus_. The _corpora_ used in this process
are very rich in annotations, in order to extract all of it consider using one
of the tools found in [Linguateca][55].

Further information about the subject can be found in the following sources:

```
Diana Santos. "O modelo semântico usado no Primeiro HAREM". In Diana Santos & Nuno Cardoso (eds.), Reconhecimento de entidades mencionadas em português: Documentação e actas do HAREM, a primeira avaliação conjunta na área. Linguateca, 2007, pp. 43-57.
http://www.linguateca.pt/aval_conjunta/LivroHAREM/Cap04-SantosCardoso2007-Santos.pdf

Diana Santos. "Evaluation in natural language processing". European Summer School on Language, Logic and Information (ESSLLI 2007) (Trinity College, Dublin, Irlanda, 6-17 de Agosto de 2007).
```

---

[Read more about the process of training][56].

Thanks
------

* *[HAREM / Linguateca team][57]* for the semantic annotated _corpus_ in
  Portuguese.
* *[Stanford NLP team][58]* for the [Stanford NER][59] tool.

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

* [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection][60] Parser.
* [Stanford NER][61] Generator.

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
[16]: https://github.com/dasdad/corpus-processor
[17]: http://www.linguateca.pt/HAREM/
[18]: http://www.linguateca.pt/
[19]: https://www.dropbox.com/sh/8p6cbbcaoyv23u7/GxY0qKObYV/corpus
[20]: http://www.linguateca.pt/
[21]: https://github.com/dasdad/corpus-processor
[22]: http://nlp.stanford.edu/software/CRF-NER.shtml
[23]: http://nlp.stanford.edu/software/CRF-NER.shtml
[24]: http://nlp.stanford.edu/software/CRF-NER.shtml
[25]: http://nlp.stanford.edu/software/CRF-NER.shtml
[26]: http://nlp.stanford.edu/software/CRF-NER.shtml
[27]: http://nlp.stanford.edu/software/CRF-NER.shtml
[28]: ftp://ftp.inf.puc-rio.br/pub/docs/techreports/07_09_duarte.pdf
[29]: http://www.linguateca.pt
[30]: http://nlp.stanford.edu/software/crf-faq.shtml
[31]: http://www.linguateca.pt/HAREM
[32]: http://www-nlp.stanford.edu/
[33]: http://nlp.stanford.edu/software/CRF-NER.shtml
[34]: http://en.wikipedia.org/wiki/Corpus_linguistics
[35]: http://www.linguateca.pt
[36]: http://nlp.stanford.edu/software/CRF-NER.shtml
[37]: http://www.linguateca.pt
[38]: http://nlp.stanford.edu/software/CRF-NER.shtml
[39]: http://en.wikipedia.org/wiki/Named-entity_recognition
[40]: http://www.ruby-lang.org/
[41]: http://rubygems.org/
[42]: https://github.com/dasdad/corpus-processor
[43]: http://www.linguateca.pt/HAREM/
[44]: http://www.linguateca.pt/
[45]: https://www.dropbox.com/sh/8p6cbbcaoyv23u7/GxY0qKObYV/corpus
[46]: http://www.linguateca.pt/
[47]: https://github.com/dasdad/corpus-processor
[48]: http://nlp.stanford.edu/software/CRF-NER.shtml
[49]: http://nlp.stanford.edu/software/CRF-NER.shtml
[50]: http://nlp.stanford.edu/software/CRF-NER.shtml
[51]: http://nlp.stanford.edu/software/CRF-NER.shtml
[52]: http://nlp.stanford.edu/software/CRF-NER.shtml
[53]: http://nlp.stanford.edu/software/CRF-NER.shtml
[54]: ftp://ftp.inf.puc-rio.br/pub/docs/techreports/07_09_duarte.pdf
[55]: http://www.linguateca.pt
[56]: http://nlp.stanford.edu/software/crf-faq.shtml
[57]: http://www.linguateca.pt/HAREM
[58]: http://www-nlp.stanford.edu/
[59]: http://nlp.stanford.edu/software/CRF-NER.shtml
[60]: http://www.linguateca.pt/HAREM/
[61]: http://nlp.stanford.edu/software/CRF-NER.shtml
