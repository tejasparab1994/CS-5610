defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add(:title, :string, null: false)
      add(:body, :text, null: false)
      add(:completed, :boolean, default: false)
      add(:assigned_id, references(:users, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:tasks, [:assigned_id]))
  end
end
