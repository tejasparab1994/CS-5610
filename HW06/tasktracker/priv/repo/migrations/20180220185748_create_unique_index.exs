defmodule Tasktracker.Repo.Migrations.CreateUniqueIndex do
  use Ecto.Migration

  def change do
    create(unique_index(:users, [:name]))
  end
end
