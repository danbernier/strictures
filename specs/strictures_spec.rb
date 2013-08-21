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

  describe 'checking if the data is in a collection' do
    it 'can tell if the data is in the collection' do
      Strictures.check(42, Strictures.one_of(42, 99)).must_be :valid?
    end

    it 'can tell if the data is NOT in the collection' do
      Strictures.check(0, Strictures.one_of(42, 99)).wont_be :valid?
    end

    it 'can say that the data is not in the collection' do
      Strictures.check('pickle', Strictures.one_of(42, 99)).errors.must_equal [
        'Expected one of [42, 99], but got: "pickle"'
      ]
    end
  end
end
