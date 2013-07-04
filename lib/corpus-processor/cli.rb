require 'thor'

require 'corpus-processor'

# The operations available to users from CLI.
class CorpusProcessor::Cli < Thor

  option :categories,
         aliases: :c,
         banner:  'CATEGORIES_FILE',
         desc:    'Path to categories YAML file'
  desc 'process [INPUT_FILE [OUTPUT_FILE]]',
    'convert corpus from LâMPADA format to Stanford-NER format'
  # Convert a given corpus from one format to other.
  #
  # By default the input format is LâMPADA and the output format is the one
  # used by Stanford NER in training.
  #
  # @param input_file [String, IO] the file that contains the original corpus.
  # @param output_file [String, IO] the file in which the converted corpus
  #   is written.
  # @return [void]
  def process input_file = STDIN, output_file = STDOUT
    input_file  = File.open( input_file, 'r') if  input_file.is_a? String
    output_file = File.open(output_file, 'w') if output_file.is_a? String
    categories  = if options[:categories]
                    CorpusProcessor::Categories.load(options[:categories])
                  else
                    CorpusProcessor::Categories.default
                  end

    output_file.puts CorpusProcessor::Processor.new(categories: categories)
                                               .process(input_file.read)

    output_file.close
  end
end
