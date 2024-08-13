defmodule LibraryWeb.CategoryLive.FormComponent do
  use LibraryWeb, :live_component

  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.form
        for={@form}
        id="category-form"
        phx-change="validate"
        phx-submit="save"
      >
        <.label>Category Name</.label>
        <.input field={@form[:name]} type="text" />
        <.button type="button" phx-disable-with="Saving...">Save Category</.button>
      </.form>
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
  def handle_event("validate", %{"category" => category_params}, socket) do
    Logger.info("validate")

    category_params
    |> inspect()
    |> Logger.info()

    {:noreply,
     assign(socket, form: AshPhoenix.Form.validate(socket.assigns.form, category_params))}
  end

  def handle_event("save", %{"category" => category_params}, socket) do
    Logger.info("save")

    category_params
    |> inspect()
    |> Logger.info()

    case AshPhoenix.Form.submit(socket.assigns.form, params: category_params) do
      {:ok, category} ->
        notify_parent({:saved, category})

        socket =
          socket
          |> put_flash(:info, "Category #{socket.assigns.form.source.type}d successfully")
          |> push_patch(to: socket.assigns.patch)

        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp assign_form(%{assigns: %{category: category}} = socket) do
    form =
      if category do
        AshPhoenix.Form.for_update(category, :update,
          as: "category",
          actor: socket.assigns.current_user
        )
      else
        AshPhoenix.Form.for_create(Library.Resource.Library.Category, :create,
          as: "category",
          actor: socket.assigns.current_user
        )
      end

    assign(socket, form: to_form(form))
  end
end
