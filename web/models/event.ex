defmodule Aly.Event do
  use Aly.Web, :model

  schema "events" do
    field :name, :string
    field :properties, :map
    belongs_to :session, Aly.Session
    timestamps
  end

  @required_fields ~w(name session_id)
  @optional_fields ~w(properties)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
