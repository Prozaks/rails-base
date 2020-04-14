FROM ruby:2.7.1-alpine
LABEL maintainer="Camus <jose.camus@usach.cl>"

# Set local timezone
RUN apk add --update tzdata && \
  cp /usr/share/zoneinfo/America/Santiago /etc/localtime && \
  echo "America/Santiago" > /etc/timezone

# Install essential Linux packages
RUN apk add --update --virtual runtime-deps postgresql-client nodejs libffi-dev readline imagemagick git file
RUN apk add --update --virtual build-deps build-base openssl-dev mariadb-dev postgresql-dev libc-dev \
  linux-headers libxml2-dev libxslt-dev readline-dev make ruby-json less sqlite-dev

RUN apk add --no-cache --update build-base \
    linux-headers \
    git \
    postgresql-dev \
    nodejs \
    yarn \
    tzdata
    
# Point Bundler at /gems. This will cause Bundler to re-use gems that have already been installed on the gems volume
ENV BUNDLE_PATH /gems
ENV BUNDLE_HOME /gems

# Where Rubygems will look for gems, similar to BUNDLE_ equivalents.
ENV GEM_HOME /gems
ENV GEM_PATH /gems

# Add /gems/bin to the path so any installed gem binaries are runnable from bash.
ENV PATH /gems/bin:$PATH

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.1.4
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

COPY . .

# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 3000
EXPOSE 3001