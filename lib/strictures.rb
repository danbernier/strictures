module Strictures
  extend self

  class Results
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end

    def valid?
      @errors.empty?
    end
  end

  def check(obj, *strictures)
    errors = strictures.map { |stricture|
      stricture.call(obj)
    }

    Results.new(errors.compact)
  end

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
end
