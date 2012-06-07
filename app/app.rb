# coding: UTF-8

require 'sass'
require 'coffee-script'

class MarkupTemplate < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  layout :layout

  set :delivery_method, :smtp => { 
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :user_name            => 'my.markup.template@gmail.com',
    :password             => 'qwerty',
    :authentication       => :plain,
    :enable_starttls_auto => true  
  }

  helpers do
    def md5 str = ''
      Digest::MD5.hexdigest str.to_s
    end

    def email_image name, options, is_mail = false
      return image_tag(name, options) unless is_mail
      options.merge!(:src => "cid:#{name}")
      tag :img, options
    end

    def partial name, options = {}
      parts = name.split '/'
      name  = parts.pop
      path  = [parts, "_#{name}"].join '/'
      haml path.to_sym, :locals => options[:locals], :layout => false
    end
  end

  # Pages
  get '/' do
    haml :index
  end

  get '/about' do
    haml :about, :locals => { :name => 'Sinatra Markup App' }
  end

  get '/mail/letter' do
    haml :"../mailers/letter", :locals => { :is_mail => false }
  end

  # SEND MAIL
  before '/mail/send' do
    @@img_path    = "#{Padrino.root}/public/images/"
    @@attachments = [
      'sinatra.png'
    ]
  end

  get '/mail/send' do
    html_letter = haml(:"../mailers/letter", :locals => { :is_mail => true }, :layout => false)

    email do
      from     'my.markup.template@gmail.com'
      to       'my.markup.template@gmail.com'
      subject  'Welcome!'
      via      :smtp
      provides :html
      html_part html_letter

      @@attachments.each_with_index do |name, index|
        add_file :filename => name, :content => File.read(@@img_path + name)
        self.attachments[index].content_id = "<#{name}>"
      end
    end
    
    redirect '/mail/letter'
  end

  # Routes to COFFEE-JS and SCSS-CSS
  get '/javascripts/:name.js' do
    content_type 'text/javascript', charset: 'utf-8'
    coffee :"../../public/javascripts/coffee/#{params[:name]}"
  end

  get '/stylesheets/:name.css' do
    content_type 'text/css', charset: 'utf-8'
    scss :"../../public/stylesheets/scss/#{params[:name]}", :style => :expanded
  end

end