defmodule Library.Resources.Library.Author do
  use Ash.Resource,
    otp_app: :library,
    domain: Library.Resources.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "authors"
    repo Library.Repo
  end

  attributes do
    # ID
    # Fullname
    # Bio
  end

  relationships do
    # has_many :books
  end
end