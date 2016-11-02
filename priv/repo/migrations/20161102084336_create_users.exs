defmodule Aly.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :string, primary_key: true
      add :data, :map
      timestamps
    end

    alter table(:events) do
      remove :session_id
      add :user_id, :string
    end

    drop table(:sessions)
  end
end
