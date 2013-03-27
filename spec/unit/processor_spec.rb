require 'spec_helper'

describe Corpus::Processor do
  subject(:processor) { Corpus::Processor.new }

  describe '#initialize' do
    it 'should recieve categories hash as an optional parameter' do
      Corpus::Processor.new(
        'PESSOA'      => :person,
        'LOCAL'       => :location,
        'ORGANIZACAO' => :organization,
      )
    end
  end


end
