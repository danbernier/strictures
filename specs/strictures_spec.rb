require 'spec_helper'

describe Strictures do
  describe 'comparing by type' do
    it 'can recognize same types' do
      Strictures.check('hello', Strictures.any(String)).must_be :valid?
      Strictures.check(42, Strictures.any(Fixnum)).must_be :valid?
      Strictures.check(%w[a b c], Strictures.any(Array)).must_be :valid?
    end

    it 'can recognize different types' do
      Strictures.check('hello', Strictures.any(Fixnum)).wont_be :valid?
      Strictures.check(42, Strictures.any(Array)).wont_be :valid?
      Strictures.check(%w[a b c], Strictures.any(String)).wont_be :valid?
    end

    it 'can report disappointments' do
      Strictures.check('hello', Strictures.any(Fixnum)).errors.must_equal [
        'Expected a Fixnum, got a String: "hello"'
      ]

      Strictures.check(42, Strictures.any(Array)).errors.must_equal [
        'Expected a Array, got a Fixnum: 42'
      ]

      Strictures.check(%w[a b c], Strictures.any(String)).errors.must_equal [
        'Expected a String, got a Array: ["a", "b", "c"]'
      ]
    end
  end
end
