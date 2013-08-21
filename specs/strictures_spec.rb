require 'spec_helper'

describe Strictures do
  describe 'comparing by type' do
    it 'can recognize same types' do
      Strictures.check('hello', Strictures.any(String)).must_be :valid?
      Strictures.check(42, Strictures.any(Fixnum)).must_be :valid?
    end

    it 'can recognize different types' do
      Strictures.check(42, Strictures.any(Array)).wont_be :valid?
      Strictures.check(%w[a b c], Strictures.any(String)).wont_be :valid?
    end

    it 'can report disappointments' do
      Strictures.check('hello', Strictures.any(Fixnum)).errors.must_equal [
        'Expected a Fixnum, got a String: "hello"'
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

  describe 'checking multiple requirements' do
    describe 'when all conditions are met' do
      it 'will say it is valid' do
        Strictures.check(0, Strictures.any(Fixnum), Strictures.one_of(0,2,4)).must_be :valid?
      end
    end

    describe 'when one condition is not met' do
      it 'will say it is not valid' do
        Strictures.check(99, Strictures.any(Fixnum), Strictures.one_of(0,2,4)).wont_be :valid?
        Strictures.check('abc', Strictures.any(Fixnum), Strictures.one_of('abc',2)).wont_be :valid?
      end

      it 'will return the right error message for the failure' do
        Strictures.check(99, Strictures.any(Fixnum), Strictures.one_of(0,2,4)).errors.must_equal [
          'Expected one of [0, 2, 4], but got: 99'
        ]

        Strictures.check('abc', Strictures.any(Fixnum), Strictures.one_of('abc',2)).errors.must_equal [
          'Expected a Fixnum, got a String: "abc"'
        ]
      end
    end

    describe 'when many conditions are not met' do
      it 'will say it is not valid' do
        Strictures.check('abc', Strictures.any(Fixnum), Strictures.one_of(0,2,4)).wont_be :valid?
      end

      it 'will return all error messages for the failures' do
        # TODO: Not sure if this is the way to go, but we'll stick with it for now.
        Strictures.check('abc', Strictures.any(Fixnum), Strictures.one_of(0,2,4)).errors.must_equal [
          'Expected a Fixnum, got a String: "abc"',
          'Expected one of [0, 2, 4], but got: "abc"'
        ]
      end
    end
  end
end
