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
  end
end
