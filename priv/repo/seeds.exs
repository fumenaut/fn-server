# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fumenaut.Repo.insert!(%Fumenaut.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Fumenaut.Account.User
alias Fumenaut.Journal.Smoke
alias Fumenaut.Repo

Repo.insert!(%User{username: "alice", email: "alice@somesite.com"})
Repo.insert!(%User{username: "bob", email: "bob@somesite.com"})
users = Repo.all(User)

alice = Enum.at(users, 0)
for _ <- 1..3 do
  Repo.insert!(%Smoke{
    title: Faker.Lorem.sentence,
    body: Faker.Lorem.paragraph,
    user_id: alice.id
  })
end

bob = Enum.at(users, 1)
for _ <- 1..7 do
    Repo.insert!(%Smoke{
      title: Faker.Lorem.sentence,
      body: Faker.Lorem.paragraph,
      user_id: bob.id
    })
end
