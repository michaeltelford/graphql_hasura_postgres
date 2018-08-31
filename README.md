# GraphQL Hasura PostgreSQL

Example GraphQL project using Hasura and a PostgreSQL database, all run inside Docker containers.

Inspired by [this tutorial](https://blog.hasura.io/postgres-views-and-materialized-views-with-graphql-fd75680888b8) (which offers in part a user guide for this repo).

## Usage

### Start App

In a shell, execute the following command to start the docker containers:

        $ docker-compose up -d

### Hasura Console

Browse to [localhost:8080](http://localhost:8080/console) to open the Hasura console.

#### Data Tab

Manipulate the GraphQL data layer using the `Data` tab. The `init_db.sql` script provides a sample DB containing authors and articles for testing with.

**Note** that any changes made in the `Data` tab manipulate the GraphQL data layer only, not Postgres underneath. For example, adding a relationship here does not add one in Postgres. This makes GraphQL perfect for sitting on top of legacy data stores.

#### GraphiQL Tab

Query the data using the `GraphiQL` tab. The `< Docs` link on the right of the query window offers information on constructing queries and is a good place to learn more.

#### Example GraphQL Queries

Below are some basic example queries for the sample database to get you started.

##### Get Each Author's Username & Their Article Titles

```
{
  author {
    username
    articlesByauthorId {
      title
    }
  }
}
```

##### Get A Specific Author's Username & Their Article Titles

```
{
  author(where: {username: {_eq: "Michael Telford"}}) {
    username
    articlesByauthorId {
      title
    }
  }
}
```

### HTTP Client

You can use any HTTP client (Postman or AJAX etc.) to query a GraphQL API. The main difference between a GraphQL and RESTful API is that GraphQL has only one endpoint. The client decides what data comes back in the response, unlike with RESTful applications.

The GraphQL query portion is sent as a HTTP request body with `Content-Type: application/json`. 

Below is a full example query sent using `curl` from a shell to query the Hasura GraphQL engine. Notice how the GraphQL query is wrapped inside a JSON `"query"` object.

```sh
curl -X POST \
  http://localhost:8080/v1alpha1/graphql \
  -H 'Content-Type: application/json' \
  -d '{
  "query": "{
    author {
      username
      articlesByauthorId {
        title
      }
    }
  }"
}'
```

The response will look something like:

```json
{
    "data": {
        "author": [
            {
                "username": "Michael Telford",
                "articlesByauthorId": [
                    {
                        "title": "Writing Tests"
                    },
                    {
                        "title": "Rapid Application Development"
                    }
                ]
            },
            {
                "username": "John Smith",
                "articlesByauthorId": [
                    {
                        "title": "My first article"
                    },
                    {
                        "title": "My second article"
                    }
                ]
            },
            {
                "username": "Joanna Smith",
                "articlesByauthorId": [
                    {
                        "title": "Environmentalism"
                    }
                ]
            }
        ]
    }
}
```
