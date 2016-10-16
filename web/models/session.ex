defmodule Aly.Session do
  use Aly.Web, :model

  schema "sessions" do
    field :client_id, :string
    timestamps
  end

  @required_fields ~w(client_id)
  @optional_fields ~w()

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
