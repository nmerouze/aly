defmodule Aly.Funnel do
  use Aly.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "funnels" do
    field :name, :string
    field :steps, {:array, :map}
    timestamps
  end

  @required_fields ~w(name steps)
  @optional_fields ~w()

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(filter(params), @required_fields, @optional_fields)
  end

  defp filter(%{"steps" => steps} = params) when is_binary(steps) do
    final_steps =
      steps
      |> String.split("\r\n")
      |> Enum.map(fn(v) -> %{"event" => String.trim(v)} end)

    Map.put(params, "steps", final_steps)
  end
  defp filter(params), do: params
end
