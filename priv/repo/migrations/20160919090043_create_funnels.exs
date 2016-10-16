defmodule Aly.Repo.Migrations.CreateFunnels do
  use Ecto.Migration

  def change do
    create table(:funnels, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :steps, {:array, :map}, default: []
      timestamps
    end
  end
end
