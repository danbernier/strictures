module Strictures
  module Rules
    def any(klass)
      ->(x) {
        unless x.is_a?(klass)
          "Expected a #{klass.name}, got a #{x.class.name}: #{x.inspect}"
        end
      }
    end

    def one_of(*items)
      ->(x) {
        unless items.include?(x)
          "Expected one of #{items.inspect}, but got: #{x.inspect}"
        end
      }
    end

    def matches_hash(example_hash)
      ->(actual_hash) {
        example_hash.each do |key, rule|
          actual_hash[key]
        end
      }
    end
  end
end
