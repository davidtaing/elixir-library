defmodule Library.Resources.Library do
  use Ash.Domain

  resources do
    resource Library.Resources.Library.Book
    resource Library.Resources.Library.Author
  end
end
