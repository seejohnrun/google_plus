# GooglePlus

This is a Ruby client library for the [Google+ API](http://developers.google.com/+/api/).

## Installation

``` bash
gem install google_plus
```

## Authentication

To make calls to the Google+ API, you have to either authenticate via [OAuth](http://oauth.net/) or provide an API key (which you can get from the Google [APIs Console](https://code.google.com/apis/console#access).  To set your API key and get started, use:

``` ruby
GooglePlus.api_key = 'your key'
```

That key will then be used on all of your requests.

## People

Getting information about a person is easy, given that you have their Google+ ID:

``` ruby
person = GooglePlus::Person.get(123)
```

Accessing attributes of a `GooglePlus::Person` object is straightforward, and to keep things nice, all attributes are converted to snake case (so `person.displayName` becomes `person.display_name`).

``` ruby
person = GooglePlus::Person.get(123)
person.display_name
person.photos.each do |photo|
  photo.value
end
```

You can read more about the fields available for a `Person` in the [Person documentation](http://developers.google.com/+/api/latest/people), or you can use the `attributes` method to get them back as a Hash.

## Activities

Exactly the same as people, you can get activities by ID:

``` ruby
activity = GooglePlus::Activity.get(123)
```

And once you have an activity, you can move back to its person using `#person`.

## People do Things

Lastly, you can get a list of activities for a person, which is returned as a `GooglePlus::Cursor`.  You use it like:

``` ruby
person = GooglePlus::Person.new(123)
cursor = person.activities_list
while cursor.next_page
  cursor.items.count # a batch of activities
end
```

Or if you just want one page, you can have it:

``` ruby
person = GooglePlus::Person.new(123)
activites = person.activities_list.items
```

You can also set the cursor size at any time using any of these variations:

``` ruby
# on the cursor
cursor = person.activities_list(:max_results => 10)
# or on the page
cursor.next_page(:max_results => 5)
```

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
