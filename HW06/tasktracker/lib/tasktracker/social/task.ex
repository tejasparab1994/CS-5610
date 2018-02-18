defmodule Tasktracker.Social.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Task

  schema "tasks" do
    field(:body, :string)
    field(:completed, :boolean, default: false)
    field(:title, :string)
    belongs_to(:user, Tasktracker.Accounts.User, foreign_key: :assigned_id)

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :body, :completed, :assigned_id])
    |> validate_required([:title, :body, :completed, :assigned_id])
  end
end
