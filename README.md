# Fumenaut

Fumenaut provides a cigar smoker journal service implemented in terms of a
Phoenix 1.3 system providing:

  * A GraphQL API endpoint.
  * A Repo for persistence of User's Smokes.

Installation involves:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Seed database with `mix run priv/repo/seeds.exs`
  * Start Phoenix endpoint with `mix phx.server`

Once started, you can visit [`localhost:4000`](http://localhost:4000) from your browser.


Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
