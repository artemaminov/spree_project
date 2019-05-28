source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'awesome_print'
   # errors in brouser
  gem 'binding_of_caller'
  
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'spree', '~> 3.5.0'
gem 'spree_auth_devise', '~> 3.3'
gem 'spree_gateway', '~> 3.3'
gem 'spree_i18n', github: 'spree-contrib/spree_i18n'
gem 'spree_address_book', github: 'spree-contrib/spree_address_book'
gem 'spree_editor', github: 'spree-contrib/spree_editor'
gem 'spree_drop_ship', github: 'spree-contrib/spree_drop_ship'
gem 'spree_related_products', github: 'spree-contrib/spree_related_products'
gem 'spree_active_shipping', github: 'spree-contrib/spree_active_shipping'

gem 'globalize', github: 'globalize/globalize'
gem 'spree_globalize', github: 'spree-contrib/spree_globalize', branch: 'master'
gem 'spree_static_content', github: 'spree-contrib/spree_static_content'
gem 'spree_recently_viewed', github: 'spree-contrib/spree_recently_viewed'
# gem 'spree_blogging_spree', github: 'stefansenk/spree-blogging-spree'


gem 'spree_print_invoice', github: 'spree-contrib/spree_print_invoice', branch: 'master'



group :production do
  gem 'unicorn'
end

# gem 'fastercsv'
gem 'geokit'
gem 'geokit-rails'
# gem 'ym4r'
# gem 'ym4r_gm', path: 'http://svn://rubyforge.org/var/svn/ym4r/Plugins/GM/trunk/ym4r_gm'
gem 'geocoder'
#gem 'gmaps4rails'


gem 'charlock_holmes'
gem 'spreadsheet'
gem 'roo'
gem 'roo-xls'



# gem 'spree_sellers'
# gem 'spree_worldtrade', github: 'diiner/spree_worldtrade'
