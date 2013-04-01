Corpus Processor
================

[![Gem Version](https://fury-badge.herokuapp.com/rb/corpus-processor.png)](http://badge.fury.io/rb/corpus-processor)

* [Versão em português](#versao-em-portugues)
* [English version](#english-version)

Versão em portuguễs
===================

Ferramenta para trabalhar com [Linguística de Corpus](http://pt.wikipedia.org/wiki/Lingu%C3%ADstica_de_corpus). Corpus Processor converte _corpora_ entre diferentes formatos para serem usado em ferramentas de Processamento de Linguagem Natural (NLP).

O primeiro propósito do Corpus Processor e seu único recurso implementado até agora é transformar _corpora_ encontrados no [Linguateca](http://www.linguateca.pt) para o formato usado pelo treinamento do [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml).

[Linguateca](http://www.linguateca.pt) é uma fonte de _corpora_ em português.

[Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml) é uma implementação de [Reconhecimento de Entidade Mencionada (NER)](http://pt.wikipedia.org/wiki/Reconhecimento_de_entidade_mencionada).

Instalação
----------

Corpus Processor é uma [Ruby](http://www.ruby-lang.org/) [Gem](http://rubygems.org/). Para instalar, dada uma instalação de Ruby, rode:

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

Para um exemplo de conversão usando o Corpus Processor, veja este [gist](https://gist.github.com/leafac/5259008).

O _corpus_ é do [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection](http://www.linguateca.pt/HAREM/) e o treinamento usou o [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml).

Agradecimentos
--------------

* [Time do HAREM / Linguateca](http://www.linguateca.pt/HAREM) pelo _corpus_ com anotações semânticas em português.
* *[Time de NLP de Stanford](http://www-nlp.stanford.edu/)* pela ferramenta [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml).

English version
===============

Tool to work with [Corpus Linguistics](http://en.wikipedia.org/wiki/Corpus_linguistics). Corpus Processor converts _corpora_ between different formats for use in Natural Language Processing (NLP) tools.

The first purpose of Corpus Processor and its current only feature is to transform _corpora_ found in [Linguateca](http://www.linguateca.pt) into the format used for training in [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml).

[Linguateca](http://www.linguateca.pt) is an source of _corpora_ in Portuguese.

[Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml) is an implementation of [Named Entity Recognition](http://en.wikipedia.org/wiki/Named-entity_recognition).

Installation
------------

Corpus Processor is a [Ruby](http://www.ruby-lang.org/) [Gem](http://rubygems.org/). To install it, given a working installation of Ruby, run:

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

For an example of converting one _corpus_ with Corpus Processor, refer to this [gist](https://gist.github.com/leafac/5259008).

The _corpus_ is from [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection](http://www.linguateca.pt/HAREM/) and the training used [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml).

Thanks
------

* [HAREM / Linguateca team](http://www.linguateca.pt/HAREM) for the semantic annotated _corpus_ in Portuguese.
* *[Stanford NLP team](http://www-nlp.stanford.edu/)* for the [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml) tool.

Contributing
------------

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.

Changelog
---------

### 0.0.1

* [LâMPADA 2.0 / Classic HAREM 2.0 Golden Collection](http://www.linguateca.pt/HAREM/) Parser.
* [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml) Generator.

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
