# Use the official Ruby image as base
FROM ruby:3.1

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    default-mysql-client

RUN mkdir /events
WORKDIR /events

COPY package.json ./

# Install JavaScript dependencies using npmf
RUN npm install

# Copy Gemfile and Gemfile.lock
COPY Gemfile ./

# Install gems
# RUN bundle install

#Docker build image 
#docker build -t event-image .

#Docker run container 
#docker run -p 3000:3000 -v "{current_directory}:events -d -it event-image