# Event Repository Documentation

This repository contains code for the Event application.

## Prerequisites

Before you start, ensure that you have Docker installed on your system.

## Getting Started

Follow these steps to set up and run the application:

1. **Build Docker Image**: Build a Docker image for the application.
    ```
    docker build -t event-image .
    ```

2. **Run Docker Container**: Run a Docker container with the built image.
    ```
    docker run -p 3000:3000 -v "$(pwd):/events" -d -it event-image
    ```

3. **Access Container Shell**: Access the shell of the running container.
    ```
    docker exec -it <container-id> bash
    ```

4. **Install Dependencies**: Inside the container, install Ruby dependencies using Bundler.
    ```
    bundle install
    ```

5. **Database Migration**: Run database migrations.
    ```
    rails db:migrate
    ```

6. **Seed Database**: Seed the database with initial data.
    ```
    rails db:seed
    ```

7. **Start Server**: Start the Rails server.
    ```
    rails s -p 3000 -b 0.0.0.0
    ```

8. **Access Application**: Open your web browser and navigate to [http://localhost:3000](http://localhost:3000).

