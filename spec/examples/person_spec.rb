require File.dirname(__FILE__) + '/../spec_helper'

describe GooglePlus::Person do

  describe :get do

    describe 'when authenticated' do

      before :all do
        GooglePlus.api_key = TEST_API_KEY
      end

      it 'should be able to get a user by id' do
        person = GooglePlus::Person.get('105735510282572548726')
        person.should be_a GooglePlus::Person
      end

      it 'should be able to get a list of activites by user' do
        person = GooglePlus::Person.get('105735510282572548726')
        acts = person.list_activities.items
        acts.should_not be_empty
        acts.each { |a| a.should be_a(GooglePlus::Activity) }
      end

    end

  end

end
