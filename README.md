# Rails Survey
A rails setup for creating very simple surveys deployable to heroku

[See it in action](http://rails-survey.herokuapp.com)

## Background

Needed a mechanism to capture some feedback with advanced features that could not be found in many other free websites. 
Also using Javascript makes the survey allows some cool manipulations like skipping around or testing answers 
based on formulas. With this version you can get:
 1. Granularity in the sense of the types of users
 2. Time to answer questions (at least the difference between)
 3. Javascript and Ruby functionality to manipulate the questions/answers
  * For example, random sets, popup boxes, skipping
 4. Customization beyond your wildest dreams

## Getting Started

*Note: This assumes you have Ruby 1.9.2 or later installed properly and have a basic working knowledge of how to use RubyGems*

Fork and clone this repo, setup dependencies, create the databse, and run using these commands

```bash
git clone https://github.com/stealthflyer/rails-survey.git
bundle install --without production
rake db:migrate
rails s
```

### Deploying to Heroku

```bash
heroku create
git push heroku master
heroku run rake db:migrate
heroku open
```

### Capturing results

The current method is to store off the ip and start times to correlate a single user. You can access this via the standard
show routine of the questions controller (visit /questions). These can be exported into Excel fairly easily via copy paste
and then manipulated there for some extra info

## Customizing

The whole point of the framework is to customize. Some sample files have been created to demonstrate.
 * [index](app/views/home/index.html.erb) - a basic questionnaire demonstrating types of questions
 * [random](app/views/home/random.html.erb) - demonstration of what code can do in a survey, reads a directory randomly 
and creates a slideshow with a predefined set of questions

There are two options for making this your own:
 1. Use the index as the primary controller and perform your entire survey from there, just add the questions
 2. Break it into pieces by adding the `onComplete()` function to your page, which would be called when a successful AJAX post is made.
 3. (I lied :P) You can change the framework any way you want

### Creating questions
Create a hash as with entries `:q` for the question, `:a` for the answer(s), `:s` for the javascript function, `:t` for the type of question
For example in [index.html.erb](app/views/home/index.html.erb):
```ruby
@questions = [ {
:q => "Do you like this solution?",
:a => ["Yes", "No", OTHER], # OTHER is a special keyword
} ]
```
The types are 
 * `BUTTON` - default, if you don't fill in a type
 * `TEXTBOX` - the answers are labels for each box (if you leave it blank, then it uses a bigger textbox)
 * `CHECKBOX` - the `OTHER` field will convert to a text box

Then you can invoke the pre-built template [default_set](app/views/questions/_default_set.html.erb) by using the code:
```ruby
<%= render :partial => "questions/default_set", :locals => { 
 :set => "sample", 
 :description => "Sample instructions", 
 :questions => @questions } %>
```

It is important that the questions are wrapped in a div layer with the class "set", which bundles the questions together.

### Javascript extensibility
The javascript functions will be called before submitting the result. With a bit of jQuery you can manipulate the answers or perform a variety
of actions based on the result. The function `SKIP_CONDITIONAL` has been defined whereby you can pass the arguments this, a condition, 
how many to skip if condition is met, how many to skip otherwise. For more see [index.html.erb](app/views/home/index.html.erb).

### Image survey template
One of the needed features was to ask questions about images. Using [nivo slider](vendor/licenses/nivo-license.txt), a template [default_set_images](app/views/questions/_default_set_images.html.erb)
was created. An example of how it is used is in the [random](app/views/home/random.html.erb) action, which reads the images
in the [image assets / set](app/assets/images/sets) folder grouped by images (.jpg) and a description.html. This is used to render
a sliding image set that you can ask about. For example, if you needed to showcase a variety of solutions and wanted to ask
the user about each set, all you need to do is add the image files and update the questions in the [random action](app/controllers/home_controller.rb).

## Improvement Opportunities (`bugs`)
This is my first official foray into Rails, so there are lots of ways to make it better. Here are a few I know about:
* Cross browser, device portability. Some versions of Internet Explorer don't work (yuck IE 7)
 * Tested on Safari, Chrome, Firefox, IE (9), Android
* The session variable gets reset because of the CSRF problem, [workaround](app/controllers/application_controller.rb) is in place
* Mobile version works, but not all platforms tested
* Checkboxes should scale up (textboxes and checkboxes dont flow with the rest of the CSS)
* More extensible, more templates (there should be more ways to minimize code)
* Better version of the results

