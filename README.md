# Carbon

## Basic Information

This Elixir application fetches data from NationalGrid's Carbon Intensity website using their free API, and stores them into a database.

Software Stack:

* Elixir, version: 1.11
* Database: Postgres

Libraries used:

* Mojito (HTTP Client based on Mint)
* Jason (for Json processing)
* Postgrex 
* Ecto (for interfacing with DB layer)
* Bypass (for testing only)

## Installing the application

The installation assumes Postgres database has a user with username `postgres` with password `password`. This can be setup in the `config/dev.exs` and `config/test.exs' files.

Steps to install:

```
  $ mix deps.get
  $ mix ecto.create
  $ mix ecto.migrate
```

## Configuration:

On initial run, the app will download data starting from the date/time that is stated in the configuration file `config/config.exs.`

```
config :carbon,
  ...
  starting_datetime: "2021-03-01T05:00:00Z"
```

## Running in development

```
  $ mix run --no-halt
```

or 

```
  $ iex -S mix
```

The app will first check whether there is data in the database. If so, it will schedule a task to download the next data when it's available.

If the database is empty (on the first run), it will first download a range of data starting with the date/time configured in the `config/config.exs` file.





