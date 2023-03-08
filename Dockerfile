FROM ruby:3

RUN apt update
RUN apt install -y default-mysql-client

WORKDIR /usr/src/app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

