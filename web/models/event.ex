defmodule Aly.Event do
  use Aly.Web, :model

  schema "events" do
    field :name, :string
    field :user_id, :string
    field :properties, :map
    timestamps
  end

  @required_fields ~w(name user_id)
  @optional_fields ~w(properties)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
