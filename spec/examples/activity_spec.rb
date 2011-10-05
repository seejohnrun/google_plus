require File.dirname(__FILE__) + '/../spec_helper'

describe GooglePlus::Activity do

  describe :search do

    before :each do
      GooglePlus::api_key = TEST_API_KEY
    end

    it 'should be able to search something cool' do
      cursor = GooglePlus::Activity.search('computers')
      cursor.items.should_not be_empty
      cursor.items.each { |c| c.should be_a(GooglePlus::Activity) }
    end

  end

  describe :plusoners do

    before :each do
      GooglePlus.api_key = TEST_API_KEY
    end
      
    it 'should be able to get a list of plusoners' do
      activity = GooglePlus::Activity.get('z12bwfehenrus14jq04cfvgowmqhvfzrlfo')
      plusoners = activity.plusoners
      plusoners.items.should_not be_empty
      plusoners.items.each { |r| r.should be_a(GooglePlus::Person) }
    end

  end

  describe :resharers do
    
    before :each do
      GooglePlus.api_key = TEST_API_KEY
    end
     
    it 'should be able to get a list of resharers' do
      activity = GooglePlus::Activity.get('z12bwfehenrus14jq04cfvgowmqhvfzrlfo')
      resharers = activity.resharers
      resharers.items.should_not be_empty
      resharers.items.each { |r| r.should be_a(GooglePlus::Person) }
    end

  end

  describe :list_people do
    
    before :each do
      GooglePlus.api_key = TEST_API_KEY
    end
     
    it 'should get nil for an invalid collection' do 
      activity = GooglePlus::Activity.get('z12bwfehenrus14jq04cfvgowmqhvfzrlfo')
      hellos = activity.list_people 'hello'
      hellos.items.should be_nil
    end

  end

  describe :list_comments do

    before :each do
      GooglePlus::api_key = TEST_API_KEY
    end

    it 'should be able to get comments for an activity' do
      activity = GooglePlus::Activity.get('z13idx1wmsuxublh404cerzp0r2szrcogpg0k')
      comments = activity.list_comments
      comments.items.each { |c| c.should be_a(GooglePlus::Comment) }
    end

  end

  describe :get do

    describe 'with bad credentials' do

      it 'should raise an error' do
        lambda do
          GooglePlus.api_key = '123'
          GooglePlus::Person.get(123)
        end.should raise_error GooglePlus::RequestError
      end

      it 'should raise an error with a message' do
        begin
          GooglePlus.api_key = '123'
          GooglePlus::Person.get(123)
        rescue GooglePlus::RequestError => e
          e.message.length.should be > 0
        end
      end

    end

    describe 'when authenticated' do

      before :each do
        GooglePlus.api_key = TEST_API_KEY
      end

      it 'should be able to get a list of activities by person id' do
        acts = GooglePlus::Activity.for_person('105735510282572548726').items
        acts.should_not be_empty
        acts.each { |a| a.should be_a(GooglePlus::Activity) }
      end

      it 'should be able to get an activity by id' do
        acts = GooglePlus::Activity.get('z12dh5o4hzzjujpt423wcvtq2k2igvsl0')
        acts.should be_a(GooglePlus::Activity)
      end

      it 'should be able to get a person from an activity' do
        act = GooglePlus::Activity.get('z12dh5o4hzzjujpt423wcvtq2k2igvsl0')
        act.person.should be_a(GooglePlus::Person)
      end

    end

  end

end
