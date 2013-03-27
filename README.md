Corpus Processor
================

![Corpus Processor](http://badge.fury.io/rb/corpus-processor)

Tool to work with [Corpus Linguistics](http://en.wikipedia.org/wiki/Corpus_linguistics). Corpus Processor converts _corpora_ between different formats for use in Natural Language Processing (NLP) tools.

The first purpose of Corpus Processor and its current only feature is to transform _corpora_ found in [Linguateca](http://www.linguateca.pt) into the format used for training in [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml).

[Linguateca](http://www.linguateca.pt) is an excellent source of _corpora_ in Portuguese.

[Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml) is an excellent implementation of [Named Entity Recognition](http://en.wikipedia.org/wiki/Named-entity_recognition).

Installation
------------

Corpus Processor is a [Ruby](http://www.ruby-lang.org/) [Gem](http://rubygems.org/). To install it, given a working installation of Ruby, run:

```bash
$ gem install corpus_processor
```

Usage
-----

Convert corpus from HAREM format to Stanford-NER format:

```bash
$ corpus-processor process [INPUT_FILE [OUTPUT_FILE]]
```

Results
-------

For an example of converting one corpus with Corpus Processor, refer to this [gist](https://gist.github.com/leafac/5259008).

The corpus is from [Linguateca](http://www.linguateca.pt/HAREM/) and the training used [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml).

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

* [Harem](http://www.linguateca.pt/HAREM/) Parser.
* [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml) Generator.

Thanks
------

* *Diana Santos* and her team in [Linguateca](http://www.linguateca.pt) for the semantic annotated corpus in Portuguese.
* *[Stanford NLP team](http://www-nlp.stanford.edu/)* for the [Stanford NER](http://nlp.stanford.edu/software/CRF-NER.shtml) tool.

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
