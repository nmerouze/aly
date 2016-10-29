defmodule Aly.FunnelView do
  use Aly.Web, :view

  def format_steps(steps) do
    steps
    |> Enum.map(fn(v) -> v["event"] end)
    |> Enum.join("\r\n")
  end

  def encode(funnel, data, properties) do
    Poison.encode!(%{
      steps: Enum.map(funnel.steps, fn(v) -> v["event"] end),
      data: [data],
      properties: properties
    })
  end
end
