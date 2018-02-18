defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:get_current_user)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  # move this somewhere: random plugs module?
  # import the random plugs module here
  def get_current_user(conn, params) do
    user_id = get_session(conn, :user_id)

    if user_id do
      user = Tasktracker.Accounts.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TasktrackerWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/feed", PageController, :feed)
    resources("/users", UserController)
    resources("/tasks", TaskController)
    post("/session", SessionController, :create)
    delete("/session", SessionController, :delete)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TasktrackerWeb do
  #   pipe_through :api
  # end
end
