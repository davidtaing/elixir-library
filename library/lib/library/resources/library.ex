defmodule Library.Resources.Library do
  use Ash.Domain

  resources do
    resource Library.Resources.Library.Book
    resource Library.Resources.Library.Author
    resource Library.Resources.Library.Category
  end
end
