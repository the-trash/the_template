## Sinatra/Padrino App for Frontend developers

Use HAML, SASS and Coffee Script for frontend development right now!

## Installation on Windows

### Ruby Install

- http://rubyinstaller.org/
- or direct download http://rubyforge.org/frs/download.php/76054/rubyinstaller-1.9.3-p194.exe
- Install with **Add Ruby executables to your PATH** and **Associate .rb and .rbw files**

### Download .ZIP archive with Application

- https://github.com/the-teacher/the_template
- Extract ZIP archive

You can use **git-clone way** if you want

### Windows command line actions

- start Windows command line with **cmd** command
- **gem install bundler --no-ri --no-rdoc**
- go to directory of Application
- **bundle**
- **padrino start -p 3000**

### Welcome to Application

- open your browser
- localhost:3000

## Installation on *NIX

### Ruby Install

Use your OS way to install **git**, **ruby**, **gems** or **rvm**

### Clone Application

- git clone git://github.com/the-teacher/the_template.git

### Terminal Action

- **gem install bundler --no-ri --no-rdoc**
- go to directory of Application
- **bundle**
- **padrino start -p 3000**

### Welcome to Application

- open your browser
- localhost:3000

---


## How to use HAML

- Create new action in application file **app\app.rb**

```ruby
get '/new_action' do
  haml :new_action
end
```

- Create new HAML file  **app\views\new_action.haml**

- Go to **localhost:3000/new_action**

## How to use SASS

- Create new SASS file in **public\stylesheets\scss\**

- Include SASS file in Application Layout file **app\views\layouts\layout.haml**

```ruby
= stylesheet_link_tag 'reset'
= stylesheet_link_tag 'headers'
= stylesheet_link_tag 'custom'

= stylesheet_link_tag 'NEW_SASS_FILE'
```

- Look at result **localhost:3000/stylesheets/NEW_SASS_FILE.css**

## How to use Coffee Script

- Create new Coffee Script file in **public\javascripts\coffee\**

- Include Coffee Script file in Application Layout file **app\views\layouts\layout.haml**

```ruby
= javascript_include_tag 'jquery'
= javascript_include_tag 'jquery-ui'
= javascript_include_tag 'application'

= javascript_include_tag 'NEW_COFFEE_SCRIPT_FILE'
```

- Look at result **localhost:3000/javascripts/NEW_COFFEE_SCRIPT_FILE.js**

### Helpers

## MD5 Helper

Just wrapper for Digest::MD5.hexdigest

```ruby
def md5 str = ''
  Digest::MD5.hexdigest str.to_s
end
```

## Email Image Helper

Gives direct link to Image if **:is_mail => false**, and build image tag with image **cid** if **:is_email => true**

```ruby
def email_image name, options, is_mail = false
  return image_tag(name, options) unless is_mail
  options.merge!(:src => "cid:#{name}")
  tag :img, options
end
```

```ruby
= email_image 'sinatra.png', {}, true
```

```ruby
= email_image 'sinatra.png', {}, false
```

## Partial Helper

Emulate behavior of haml partials with Rails-like style.
Partials directory is **app\views\partials\**

**Names of partials starts with underscore**

```ruby
def partial name, options = {}
  parts = name.split '/'
  name  = parts.pop
  path  = [parts, "_#{name}"].join '/'
  haml path.to_sym, :locals => options[:locals], :layout => false
end
```

```ruby
= partial 'partials/test', :locals => { :hello_variable => 'SOME VARIABLE FOR PARTIAL' }
```

**app\views\partials\\_test.haml**

## HTML letters

- Setup you Email service options in **app\app.rb** file

```ruby
set :delivery_method, :smtp => { 
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => 'my.markup.template@gmail.com',
  :password             => 'qwerty',
  :authentication       => :plain,
  :enable_starttls_auto => true  
}
```

- Use direct link **localhost:3000/mail/letter** to see your HTML letter in browser

```ruby
get '/mail/letter' do
  haml :"../mailers/letter", :locals => { :is_mail => false }
end
```

- Use send mail link **localhost:3000/mail/send** to send your email. You will be redirected to **/mail/letter** at end of sending process.

- Add attachments with **before filter**

```ruby
before '/mail/send' do
  @@img_path    = "#{Padrino.root}/public/images/"
  @@attachments = [
    'sinatra.png'
  ]
end
```

- Use **email_image 'sinatra.png', {}, true** on email sending

- Use **email_image 'sinatra.png', {}, false** one HTML letter cteating
