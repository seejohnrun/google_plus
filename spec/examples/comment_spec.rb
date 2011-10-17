require 'spec_helper'

describe GooglePlus::Comment do

  describe :for_activity do

    before :each do
      GooglePlus.api_key = TEST_API_KEY
    end

    it 'should get a list of comments for an activity' do
      cursor = GooglePlus::Comment.for_activity('z13idx1wmsuxublh404cerzp0r2szrcogpg0k')
      cursor.items.should_not be_empty
      cursor.items.each { |c| c.should be_a(GooglePlus::Comment) }
    end

    it 'should get an empty array when there are no comments' do
      cursor = GooglePlus::Comment.for_activity('z12dh5o4hzzjujpt423wcvtq2k2igvsl0')
      cursor.next_page.should be_nil
    end

  end

  describe :get do

    it 'should be able to get a comment directly' do
      comment = GooglePlus::Comment.get('IKYuteH6Bs2zbVgplVjQMQE-BkJd8qpiix5N7W1V3pYZcr6s2GoOs9brzkj6pqLyagkqKeh-DJrs5v2NSDDAwQ')
      comment.should be_a GooglePlus::Comment
    end

  end 

end
