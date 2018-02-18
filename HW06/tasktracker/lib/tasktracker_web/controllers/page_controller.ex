defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Social

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def feed(conn, _params) do
    tasks = Social.list_tasks()
    render(conn, "feed.html", tasks: tasks)
  end
end
