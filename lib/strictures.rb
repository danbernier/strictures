require 'strictures/rules.rb'

module Strictures
  include Rules
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
end
