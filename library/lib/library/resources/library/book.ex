defmodule Library.Resources.Library.Book do
  use Ash.Resource,
    otp_app: :library,
    domain: Library.Resources.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "books"
    repo Library.Repo
  end

  attribute do
    # ID
    # Title
    # Subtitle
    # Author
    # Category
    # Pages
    # Language
    # ISBN10
    # ISBN13
    # Publish Date
  end

  relationships do
    # belongs_to :author
  end
end
