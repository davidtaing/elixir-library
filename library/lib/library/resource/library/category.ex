defmodule Library.Resource.Library.Category do
  use Ash.Resource,
    otp_app: :library,
    domain: Library.Resource.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "categories"
    repo Library.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
    end
  end

  relationships do
    has_many :books, Library.Resource.Library.Book
  end
end
