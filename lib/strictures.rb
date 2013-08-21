module Strictures
  extend self

  class Result
    def initialize(valid)
      @valid = valid
    end

    def valid?
      @valid
    end
  end

  def check(obj, stricture)
    Result.new(stricture.call(obj))
  end

  def any(klass)
    ->(x) {
      x.is_a?(klass)
    }
  end
end
