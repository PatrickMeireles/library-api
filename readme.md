# Library Api

- This Api is a system based on Domain Driver Design using CQRS and Distributed Cache.


# Technologies

- .Net 6
- PostgreSql
- MongoDB
- RabbitMq
- Redis

# Steps

- Clone this repository

- In the *src/* folder and execute this commands
     - Build the docker file
        ```
        docker build -t patrick-amorim/library-api:latest -f Library.Api/Dockerfile .
        ```
    - Then execute to docker compose
        ```
        docker-compose up
        ```
- After this process, access the swagger page using the port *8090*

# Resources
## Author

    - [GET]/api/v1/authors/
    - [GET]/api/v1/authors/{id}
    - [POST]/api/v1/authors/
    - [DELETE]/api/v1/authors/{id}
    - [PUT]/api/v1/authors/{id}

## Book

    - [GET]/api/v1/books/
    - [GET]/api/v1/books/{id}
    - [POST]/api/v1/books/
    - [DELETE]/api/v1/books/{id}
    - [PUT]/api/v1/books/{id}

## Health

    - [GET]/api/health/