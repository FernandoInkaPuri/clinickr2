FROM ruby

WORKDIR /app

RUN gem install sinatra puma pg redis sidekiq rack

ADD . /app
