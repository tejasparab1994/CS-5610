defmodule Tasktracker.Social.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Task

  schema "tasks" do
    field(:body, :string)
    field(:completed, :boolean, default: false)
    field(:title, :string)
    belongs_to(:user, Tasktracker.Accounts.User, foreign_key: :assigned_id)
    field(:time_taken, :integer)

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :body, :completed, :assigned_id, :time_taken])
    |> validate_required([:title, :body, :completed, :assigned_id, :time_taken])
  end
end
