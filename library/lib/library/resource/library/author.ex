defmodule Library.Resource.Library.Author do
  use Ash.Resource,
    otp_app: :library,
    domain: Library.Resource.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "authors"
    repo Library.Repo
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      [:fullname, :bio]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :fullname, :string do
      allow_nil? false
    end

    attribute :bio, :string do
      allow_nil? false
    end
  end

  relationships do
    has_many :books, Library.Resource.Library.Book
  end
end
