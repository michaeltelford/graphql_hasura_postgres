# GraphQL Hasura PostgreSQL

Example GraphQL project using Hasura and a PostgreSQL database, all run inside Docker containers.

Inspired by [this tutorial](https://blog.hasura.io/postgres-views-and-materialized-views-with-graphql-fd75680888b8) (which offers in part a user guide for this repo).

## Usage

### Start App

In a shell, execute the following command to start the docker containers:

        $ docker-compose up -d

### Open Hasura Console

Browse to: [localhost:8080](http://localhost:8080/console) to open the Hasura console.

### Data Tab

Manipulate the GraphQL data layer using the `Data` tab. 

**Note** that any changes made here manipulate the GraphQL data layer only, not Postgres underneath. For example, adding a relationship here does not add one in Postgres. This makes GraphQL perfect for sitting on top of legacy data stores.

### GraphiQL Tab

Query the data using the `GraphiQL` tab. The `< Docs` link on the right of the query window offers information on constructing queries and is a good place to learn more.

### Example GraphQL Queries

Below are some basic example queries.

#### Get All Authors & Their Articles

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

#### Get A Specific Author & Their Articles

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
