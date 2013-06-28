require 'corpus-processor'
require 'thor'

module CorpusProcessor
  class Cli < ::Thor

    desc 'process [INPUT_FILE [OUTPUT_FILE]]',
      'convert corpus from LâMPADA format to Stanford-NER format'
    def process(input_file = STDIN, output_file = STDOUT)
      input_file  = File.open( input_file, 'r') if  input_file.is_a? String
      output_file = File.open(output_file, 'w') if output_file.is_a? String

      output_file.puts(CorpusProcessor::Processor.new.process(input_file.read))

      output_file.close
    end
  end
end
