defmodule Aly.EventQuery do
  import Ecto.Query

  def funnel(steps) do
    params = Enum.map(steps, fn(v) -> v["event"] end)

    select =
      0..(length(steps) - 1)
      |> Enum.map(fn(i) -> "SUM(e#{i}.event)" end)
      |> Enum.join(", ")

    joins =
      1..(length(steps) - 1)
      |> Enum.map(fn(i) -> join_lateral(i) end)
      |> Enum.join(" ")

    query = "SELECT ARRAY[#{select}] #{from} #{joins}"

    Ecto.Adapters.SQL.query!(Aly.Repo, query, params)
    |> Map.get(:rows)
    |> Enum.at(0)
    |> Enum.at(0)
  end

  defp from do
    "FROM (SELECT session_id, 1 AS event, MIN(inserted_at) AS time FROM events WHERE name = $1 GROUP BY session_id) e0"
  end

  defp join_lateral(step) do
    "LEFT JOIN LATERAL (SELECT 1 AS event, inserted_at AS time FROM events WHERE session_id = e0.session_id AND name = $#{step + 1} AND inserted_at BETWEEN e0.time AND (e0.time + interval '1 hour') ORDER BY inserted_at LIMIT 1) e#{step} ON true"
  end
end
