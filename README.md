# [GooglePlus](http://rubygems.org/gems/google_plus)

This is a Ruby client library for the [Google+ API](http://developers.google.com/+/api/).

## Installation

    gem install google_plus

## [Documentation](http://rdoc.info/gems/google_plus/file/README.md)

## Authentication

To make calls to the Google+ API, you have to either authenticate via [OAuth](http://oauth.net/) or provide an API key (which you can get from the Google [APIs Console](https://code.google.com/apis/console#access).  To set your API key and get started, use:

    GooglePlus.api_key = 'your key'

That key will then be used on all of your requests.

If you want to change it for an individual request, you can use a param, like:

    person = GooglePlus::Person.get(123, :key => 'other_key')

If you want to use [OAuth](http://oauth.net/) for authorization, you can use a method such as [OmniAuth](https://github.com/intridea/omniauth)'s [GoogleOAuth2 Strategy](http://rubydoc.info/gems/oa-oauth/0.3.0/OmniAuth/Strategies/GoogleOAuth2) to get an `access_token`, and then set it using:

    GooglePlus.access_token = 'token'

If you want to set it for an individual request (or series of requests), you can use a param like above:

    person = GooglePlus::Person.get(123, :access_token => 'token')

## People

Getting information about a person is easy, given that you have their Google+ ID:

    person = GooglePlus::Person.get(123)

Accessing attributes of a `GooglePlus::Person` object is straightforward, and to keep things nice, all attributes are converted to snake case (so `person.displayName` becomes `person.display_name`).

    person = GooglePlus::Person.get(123)
    person.display_name
    person.photos.each do |photo|
      photo.value
    end

You can read more about the fields available for a `Person` in the [Person documentation](http://developers.google.com/+/api/latest/people), or you can use the `attributes` method to get them back as a Hash.

## Activities

Exactly the same as people, you can get activities by ID:

    activity = GooglePlus::Activity.get(123)

And once you have an activity, you can move back to its person using `#person`.

### People do Things

Lastly, you can get a list of activities for a person, which is returned as a `GooglePlus::Cursor`.  You use it like (which auto-paginates):

    person = GooglePlus::Person.new(123)
    cursor = person.list_activities
    cursor.each do |item|
      item # an item
    end

Or if you just want one page, you can have it:

    person = GooglePlus::Person.new(123)
    activites = person.list_activities.items

You can also set the cursor size at any time using any of these variations:

    # on the cursor
    cursor = person.list_activities(:max_results => 10)
    # or on the page
    items = cursor.next_page(:max_results => 5)

### Plusoners and Resharers

You can call `plusoners` and `resharers` on a `GooglePlus::Activity` to get a cursor or people that plus one'd or reshared an activity.

## Comments

You can get comments for an acitivty, using its ID:

    comment = GooglePlus::Comment.get(123)

Accessing attributes of a `GooglePlus::Comment` object is straightforward, (see: accessing attributes of a `GooglePlus::Person`).  You can find the fields available in the [Comment documentation](https://developers.google.com/+/api/latest/comments/list).

Getting comments for an activity is done just like getting activities for a person:

    activity = GooglePlus::Activity.get(123)
    cursor = activity.list_comments
    cursor.each do |item|
      # a comment
    end

## Searching

You can search for [people](https://developers.google.com/+/api/latest/people/search) or [activities](https://developers.google.com/+/api/latest/activities/search) using the respective `search` methods, which also yield `GooglePlus::Cursor` objects.  Here's an example:

    search = GooglePlus::Person.search('john crepezzi')
    search.each do |p|
      puts p.display_name
    end

## Setting options

On any of these calls, you can provide options like `user_ip` listed on [the docs](http://developers.google.com/+/api/).

## Dependencies

* rest_client

## License

(The MIT License)

Copyright © 2011 John Crepezzi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
