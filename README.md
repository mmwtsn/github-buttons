# GitHub Buttons
A little wrapper for Mark Ottos [GitHub Buttons](https://github.com/mdo/github-buttons) to print `<iframe>` elements for your views on any open source project pushed to GitHub.

## Installation
Run `gem install github-buttons` to install the Gem locally or add it to the Gemfile of any project using Bundler and `bundle install`.

## Usage
In this example we'll create three buttons that point to this repository: "fork", "star" and "follow". The templating language here is [ERB](http://ruby-doc.org/stdlib-2.1.0/libdoc/erb/rdoc/ERB.html), though, you're welcome to use your favorite. The `GitHub::Button` class takes two strings: user name and repository name. Calling the `#style` method on that instance will allow you to print one of the three button styles with two optional parameters passed in an options hash:
- `count: true` (displays the total number of followers, stargazers or forks)
- `large: true` (increases the button size)

Note: the default values for size and style are "small" and "fork". No configuration options are needed to create a small-sized button.

The first line creates a new instance of the GitHub::Button class with the user name `mmwtsn` and repository `github-buttons`. Each additional line will print a different button. For illustrative purposes all possibile combinations are shown below.

```ruby
<% b = GitHub::Button.new('mmwtsn', 'github-buttons') %>

<%= b.style('fork') %>
<%= b.style('star') %>
<%= b.style('follow') %>

<%= b.style('fork', count: true) %>
<%= b.style('star', count: true) %>
<%= b.style('follow', count: true) %>

<%= b.style('fork', large: true) %>
<%= b.style('star', large: true) %>
<%= b.style('follow', large: true) %>

<%= b.style('fork', count: true, large: true) %>
<%= b.style('star', count: true, large: true) %>
<%= b.style('follow', count: true, large: true) %>
```

Additionally, a set of quick helper methods could be written to clean up your views.
```ruby
# Create a view helper method
 def new_button
   # Create a new button
   b = GitHub::Button.new('mmwtsn', 'github-buttons')
   # Pass the button some default styles
   b.style('star', count: true)
 end
```

## Known Issues
At the time of release, Firefox on OS X was unable to render the "small" (default) button size and, regardless of configuration, strips the first button on the page of its label and count. This appears to be a problem stemming from the original [GitHub Button](https://github.com/mdo/github-buttons) source code.

## Author
[M. Maxwell Watson](http://mmwtsn.com/)

## License
The MIT License (MIT)

````
Copyright (c) 2014 M. Maxwell Watson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
````
