defmodule LibraryWeb.Router do
  use LibraryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LibraryWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    live "/authors", LibraryWeb.AuthorLive.Index, :index
    live "/authors/new", LibraryWeb.AuthorLive.Index, :new
    live "/authors/:id/edit", LibraryWeb.AuthorLive.Index, :edit

    live "/authors/:id", LibraryWeb.AuthorLive.Show, :show
    live "/authors/:id/show/edit", LibraryWeb.AuthorLive.Show, :edit

    live "/books", LibraryWeb.BookLive.Index, :index
    live "/books/new", LibraryWeb.BookLive.Index, :new
    live "/books/:id/edit", LibraryWeb.BookLive.Index, :edit

    live "/books/:id", LibraryWeb.BookLive.Show, :show
    live "/books/:id/show/edit", LibraryWeb.BookLive.Show, :edit

    live "/categories", LibraryWeb.CategoryLive.Index, :index
    live "/categories/new", LibraryWeb.CategoryLive.Index, :new
    live "/categories/:id/edit", LibraryWeb.CategoryLive.Index, :edit

    live "/categories/:id", LibraryWeb.CategoryLive.Show, :show
    live "/categories/:id/show/edit", LibraryWeb.CategoryLive.Show, :edit
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LibraryWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", LibraryWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:library, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LibraryWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
