module CorpusProcessor
  DEFAULT_CATEGORIES = {
    input: {
      'PESSOA'      => :person,
      'LOCAL'       => :location,
      'ORGANIZACAO' => :organization,
    },
    output: Hash.new('O').merge(
        person:       'PERSON',
        location:     'LOCATION',
        organization: 'ORGANIZATION',
    )
  }
end
