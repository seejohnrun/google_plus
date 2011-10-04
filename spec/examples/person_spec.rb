require File.dirname(__FILE__) + '/../spec_helper'

describe GooglePlus::Person do

  describe :search do

    before :each do
      GooglePlus::api_key = TEST_API_KEY
    end

    it 'should be able to search for people named john' do
      cursor = GooglePlus::Person.search 'john'
      cursor.items.should_not be_empty
      cursor.items.each { |c| c.should be_a(GooglePlus::Person) }
    end

  end

  describe :get do

    describe 'when authenticated' do

      before :all do
        GooglePlus.api_key = TEST_API_KEY
      end

      it 'should be able to get a user by id' do
        person = GooglePlus::Person.get('105735510282572548726')
        person.should be_a GooglePlus::Person
      end

      it 'should turn camel case into snake case' do
        person = GooglePlus::Person.get('105735510282572548726')
        person.should_not respond_to :displayName
        person.should respond_to :display_name
      end

      it 'should be able to get a list of activites by user' do
        person = GooglePlus::Person.get('105735510282572548726')
        acts = person.list_activities.items
        acts.should_not be_empty
        acts.each { |a| a.should be_a(GooglePlus::Activity) }
      end

      it 'should be able to get a list of activites by user with max_results on cursor' do
        person = GooglePlus::Person.get('105735510282572548726')
        acts = person.list_activities
        used = []
        acts.next_page(:max_results => 1)
        acts.items.count.should == 1
        acts.items.each { |a| used << a.id }
        acts.next_page(:max_results => 1)
        acts.items.count.should == 1
        acts.items.each { |a| used.should_not include(a.id) }
      end

      it 'should be able to hit the last page and get nil items' do
        person = GooglePlus::Person.get('105735510282572548726')
        acts = person.list_activities
        acts.items(:max_results => 100)
        acts.next_page
        acts.items.should be_nil
      end

    end

  end

end
