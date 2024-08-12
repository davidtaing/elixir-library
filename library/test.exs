# this file as a script that will be hotloaded in via an iex session.
# not too focused on trying to be too correct since this project is a spike.

category = Library.Resource.Library.Category
|> Ash.Changeset.for_create(:create, %{name: "Computers & Programming"})
|> Ash.create!()

IO.puts(inspect(category))
