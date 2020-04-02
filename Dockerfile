FROM ruby:2.6.5

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /users_programs
WORKDIR /users_programs

ADD Gemfile /users_programs/Gemfile
ADD Gemfile.lock /users_programs/Gemfile.lock

RUN bundle install

ADD . /users_programs