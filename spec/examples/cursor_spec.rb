require File.dirname(__FILE__) + '/../spec_helper'

describe GooglePlus::Cursor do

  describe :each do

    it 'should go through multiple pages' do
      cursor = GooglePlus::Cursor.new(Object, :get, '/nothing')
      cursor.should_receive(:next_page).and_return(['123'])
      cursor.should_receive(:next_page).and_return(['456'])
      cursor.should_receive(:next_page).and_return(nil)
      items = []
      cursor.each { |c| items << c }
      items.should == ['123', '456']
    end

  end

end
