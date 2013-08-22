require 'spec_helper'

describe Strictures, 'mapping types (classes) to default validators' do
  it 'will turn a Class into a #any' do
    Strictures.check('hello', String).must_be :valid?
    Strictures.check('hello', Fixnum).wont_be :valid?
    Strictures.check('hello', Fixnum).errors.must_equal [
      'Expected a Fixnum, got a String: "hello"'
    ]
  end
end
