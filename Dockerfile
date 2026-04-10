FROM ruby:3.3-slim

RUN apt-get update && \
    apt-get install -y build-essential libyaml-dev && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /app
COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
