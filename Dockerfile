# Dockerfile

# Use the official Ruby image as a base
FROM ruby:3.3.5

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set up the app directory
WORKDIR /app

# Install gems
COPY Gemfile* /app/
RUN bundle install

# Copy the rest of the application code
COPY . /app

# Expose the Rails development port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
