web: bundle exec rails s -e $RACK_ENV -p $PORT
worker: bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rake db:migrate
