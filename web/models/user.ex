defmodule Aly.User do
  use Aly.Web, :model

  @primary_key {:id, :string, autogenerate: false}

  schema "users" do
    field :data, :map
    timestamps
  end

  @required_fields ~w(id)
  @optional_fields ~w(data)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
