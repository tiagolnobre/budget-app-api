FROM ruby:2.7.2-alpine

RUN apk --no-cache add build-base nodejs postgresql-dev

RUN mkdir /app
WORKDIR /app

RUN gem install bundler:2.0.2

COPY Gemfile Gemfile.lock ./
RUN bundle install -j20 --retry 5 --binstubs

COPY . .

LABEL maintainer="Tiago <tiago.l.nobre@gmail.com>"

CMD puma -C config/puma.rb
