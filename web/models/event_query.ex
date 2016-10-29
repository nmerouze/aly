defmodule Aly.EventQuery do
  import Ecto.Query, only: [from: 2]
  alias Aly.Event

  def properties do
    from e in Event,
      select: fragment("DISTINCT jsonb_object_keys(?)", e.properties)
  end

  def funnel(steps) do
    from = "FROM (SELECT session_id, 1 AS event, MIN(inserted_at) AS time FROM events WHERE name = $1 GROUP BY session_id) e0"
    query = "SELECT json_build_object('property', #{property("", "'Overall'")}, 'steps', ARRAY[#{select(steps)}]) #{from} #{joins(steps)}"

    Ecto.Adapters.SQL.query!(Aly.Repo, query, params(steps))
    |> Map.get(:rows)
    |> Enum.at(0)
    |> Enum.at(0)
  end

  def funnel(steps, property) do
    from = "FROM (SELECT properties, session_id, 1 AS event, MIN(inserted_at) AS time FROM events WHERE name = $1 GROUP BY session_id, properties) e0"
    query = "SELECT e0.properties->'#{property}' AS #{property}, json_build_object('property', #{property(property)}, 'steps', ARRAY[#{select(steps)}]) #{from} #{joins(steps)} GROUP BY #{property} ORDER BY #{property} ASC"

    Ecto.Adapters.SQL.query!(Aly.Repo, query, params(steps))
    |> Map.get(:rows)
    |> Enum.map(&Enum.at(&1, 1))
    |> List.insert_at(0, funnel(steps))
  end

  defp select(steps) do
    steps
    |> Enum.with_index
    |> Enum.map(fn({v, i}) -> "json_build_object('name', '#{v["event"]}', 'count', COALESCE(SUM(e#{i}.event), 0))" end)
    |> Enum.join(", ")
  end

  defp joins(steps) do
    1..(length(steps) - 1)
    |> Enum.map(fn(i) -> join_lateral(i) end)
    |> Enum.join(" ")
  end

  defp property(property) do
    property(property, "e0.properties->'#{property}'")
  end

  defp property(property, value) do
    "json_build_object('name', '#{property}', 'value', #{value})"
  end

  defp params(steps) do
    Enum.map(steps, fn(v) -> v["event"] end)
  end

  defp join_lateral(step) do
    "LEFT JOIN LATERAL (SELECT 1 AS event, inserted_at AS time FROM events WHERE session_id = e0.session_id AND name = $#{step + 1} AND inserted_at BETWEEN e0.time AND (e0.time + interval '1 hour') ORDER BY inserted_at LIMIT 1) e#{step} ON true"
  end
end
