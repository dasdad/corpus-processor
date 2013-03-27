module Corpus
  module Categories
    INPUT = {
      'PESSOA'      => :person,
      'LOCAL'       => :location,
      'ORGANIZACAO' => :organization,
    }

    OUTPUT = Hash.new('O').merge(
        person:       'PERSON',
        location:     'LOCATION',
        organization: 'ORGANIZATION',
    )
  end
end
