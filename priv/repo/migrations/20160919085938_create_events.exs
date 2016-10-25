defmodule Aly.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :session_id, references(:sessions)
      add :properties, :map
      timestamps
    end
  end
end
