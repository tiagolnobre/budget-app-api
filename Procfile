web: bundle exec rails s -e $RACK_ENV -p $PORT
sidekiq: bundle exec rackup -o 0.0.0.0 -p 3000 sidekiq-web.ru
worker: bundle exec sidekiq -C config/sidekiq.yml
