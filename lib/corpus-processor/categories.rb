# The helper to load categories definitions.
#
# Categories definitions is a Hash with two keys named `:input` and `:output`.
#
# The `:input` has `String` keys that match the categories found in original
# corpus. Its values are `Symbol`s that represent the category internally.
#
# The `:output` has `Symbol`s keys that represent the category internally
# and should the values from the `:input` hash. Its values are the `String`s
# representing the category in the final converted corpus.
#
# An optional `:default` key is allowed in the `:output` hash. If present
# the resulting loaded hash has the specified default value.
#
# @example YAML file defining categories.
#   ---
#   :input:
#     PESSOA: :person
#     LOCAL: :location
#     ORGANIZACAO: :organization
#   :output:
#     :default: O
#     :person: PERSON
#     :location: LOCATION
#     :organization: ORGANIZATION
class CorpusProcessor::Categories

  # Load a set of categories definitions.
  #
  # @param path [String] the path to the YAML file that defines the categories.
  # @return [Hash] the categories extracted from the YAML file.
  # @see .default
  def self.load path
    @@instances[path] ||= YAML.load(File.read(path)).tap { |categories|
      default = categories[:output] && categories[:output][:default]
      if default
        categories[:output].default = default
        categories[:output].delete :default
      end
    }
  end

  # The default set of categories definitions.
  #
  # The YAML definition file is
  # {file:lib/corpus-processor/categories/default.yml}.
  #
  # @return (see .load)
  # @see .load
  def self.default
    self.load(File.expand_path(File.join('..', 'categories', 'default.yml'),
                               __FILE__))
  end

  protected

    @@instances = Hash.new
end
