require File.dirname(__FILE__) + '/../spec_helper'

describe GooglePlus do

  it 'should not have an api' do
    GooglePlus.should_not have_api
  end

end
