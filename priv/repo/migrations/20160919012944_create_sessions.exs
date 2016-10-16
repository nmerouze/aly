defmodule Aly.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :client_id, :string
      timestamps
    end
  end
end
