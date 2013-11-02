require 'spec_helper'

describe Strictures::Rules, '.any' do
  it 'is valid for objects of same type' do
    Strictures.check('hello', Strictures.any(String)).must_be :valid?
  end

  it 'is not valid for objects of different type' do
    Strictures.check('hello', Strictures.any(Fixnum)).wont_be :valid?
  end

  it 'is valid for objects of a sub-type' do
    Strictures.check(99, Strictures.any(Numeric)).must_be :valid?
  end

  describe 'the error message' do
    it 'includes both class names, and inspects the object' do
      Strictures.check('hello', Strictures.any(Fixnum)).errors.must_equal [
        'Expected a Fixnum, got a String: "hello"'
      ]
    end
  end
end

describe Strictures::Rules, '.one_of' do
  it 'is valid if the object is in the list' do
    Strictures.check(0, Strictures.one_of(0,1,2)).must_be :valid?
  end

  it 'is valid even if the list only has 1 item, if they match' do
    Strictures.check(0, Strictures.one_of(0)).must_be :valid?
  end

  it 'is not valid if the object is not in the list' do
    Strictures.check(0, Strictures.one_of(1,2,3)).wont_be :valid?
  end

  describe 'the error message' do
    it 'inspects the list of items, and inspects the object' do
      Strictures.check('abc', Strictures.one_of(1,2)).errors.must_equal [
        'Expected one of [1, 2], but got: "abc"'
      ]
    end
  end
end

describe Strictures::Rules, '.matches_hash' do
  it 'matches values to rules by key, and applies the rules' do


#   resp = { status: 'success',
#             code: 42,
#             deets: {
#               name: 'Peet',
#               age: 11
#             }
#           }

#   puts assert(resp, status: any(Symbol),
#                 code: either(5, 23),
#                 deets: {
#                   name: /@[A-Z][a-z]+/,
#                   age: 0..100
#                 })

# That should print:

# * For :status, expected a Symbol, got: "success"
# * For :code, expected one of 5, 23, got: 42
# * For :deets / :name, expected something like (?-mix:@[A-Z][a-z]+), got: "Peet"

    actual_hash = {
      status: 'success',
      code: 42,
      deets: {
        name: 'Peet',
        age: 11
      }
    }

    rules_hash = {
      status: Strictures.any(Symbol),
      code: Strictures.one_of(5, 23),
      deets: {
        name: /@[A-Z][a-z]+/,
        age: 0..100
      }
    }

    result = Strictures.check(actual_hash, Strictures.matches_hash(rules_hash))
    result.wont_be :valid?
  end
end

























