puts "deploy to heroku"

unless system 'heroku info'
  system 'heroku create'
  system 'heroku buildpacks:add --index 1 heroku/nodejs'
  system 'heroku buildpacks:add --index 2 heroku/ruby'
end

system('git push heroku master; heroku run rake db:migrate; heroku open')
