FROM ruby:3.3-slim

RUN apt-get update -qq && apt-get install -y build-essential

WORKDIR /app
COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]
