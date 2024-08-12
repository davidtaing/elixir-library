defmodule Library.Resource.Library.Book do
  use Ash.Resource,
    otp_app: :library,
    domain: Library.Resource.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "books"
    repo Library.Repo
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:title, :subtitle, :author_id, :category_id, :pages, :language, :isbn, :isbn13, :publish_date]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    attribute :subtitle, :string do
      allow_nil? false
    end

    attribute :author_id, :uuid do
      allow_nil? false
    end

    attribute :category_id, :uuid do
      allow_nil? false
    end

    attribute :pages, :integer do
      allow_nil? false
    end

    attribute :language, :string do
      allow_nil? false
    end

    attribute :isbn, :string do
      allow_nil? false
      constraints min_length: 10, max_length: 10
    end

    attribute :isbn13, :string do
      allow_nil? false
      constraints min_length: 13, max_length: 13
    end

    attribute :publish_date, :date do
      allow_nil? false
    end
  end

  relationships do
    belongs_to :author, Library.Resource.Library.Author
    belongs_to :category, Library.Resource.Library.Category
  end
end
