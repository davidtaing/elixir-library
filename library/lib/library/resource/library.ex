defmodule Library.Resource.Library do
  use Ash.Domain

  resources do
    resource Library.Resource.Library.Book
    resource Library.Resource.Library.Author
    resource Library.Resource.Library.Category
  end
end
