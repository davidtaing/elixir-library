defmodule Library.Resources.Library.Category do
  use Ash.Resource,
    otp_app: :library,
    domain: Library.Resources.Library,
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
    has_many :books, Library.Resources.Library.Book
  end
end
