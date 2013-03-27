require 'spec_helper'

describe Corpus::TokenFormatter do
  subject(:token_formatter) { Corpus::TokenFormatter.new }

  describe '#format' do
    subject { token_formatter.format(token) }

    context 'default categories' do
      context 'default category' do
        let(:token) { Corpus::Token.new('banana') }

        it { should == 'banana	O' }
      end

      context 'PERSON category' do
        let(:token) { Corpus::Token.new('Marilyn', :person) }

        it { should == 'Marilyn	PERSON' }
      end

      context 'LOCATION category' do
        let(:token) { Corpus::Token.new('Florianópolis', :location) }

        it { should == 'Florianópolis	LOCATION' }
      end

      context 'ORGANIZATION category' do
        let(:token) { Corpus::Token.new('Google', :organization) }

        it { should == 'Google	ORGANIZATION' }
      end
    end

    context 'user-defined categories' do
      let(:token_formatter) { Corpus::TokenFormatter.new(
        fruit:        'FRUIT',
        harry_potter: 'HARRY-POTTER',
      ) }

      context 'FRUIT category' do
        let(:token) { Corpus::Token.new('Banana', :fruit) }

        it { should == 'Banana	FRUIT' }
      end

      context 'HARRY-POTTER category' do
        let(:token) { Corpus::Token.new('Hogwarts', :harry_potter) }

        it { should == 'Hogwarts	HARRY-POTTER' }
      end
    end
  end
end
