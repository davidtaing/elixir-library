defmodule LibraryWeb.BookLive.FormComponent do
  use LibraryWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage book records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="book-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <:actions>
          <.button phx-disable-with="Saving...">Save Book</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form()}
  end

  @impl true
  def handle_event("validate", %{"book" => book_params}, socket) do
    {:noreply, assign(socket, form: AshPhoenix.Form.validate(socket.assigns.form, book_params))}
  end

  def handle_event("save", %{"book" => book_params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: book_params) do
      {:ok, book} ->
        notify_parent({:saved, book})

        socket =
          socket
          |> put_flash(:info, "Book #{socket.assigns.form.source.type}d successfully")
          |> push_patch(to: socket.assigns.patch)

        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp assign_form(%{assigns: %{book: book}} = socket) do
    form =
      if book do
        AshPhoenix.Form.for_update(book, :update, as: "book", actor: socket.assigns.current_user)
      else
        AshPhoenix.Form.for_create(Library.Resource.Library.Book, :create,
          as: "book",
          actor: socket.assigns.current_user
        )
      end

    assign(socket, form: to_form(form))
  end
end
