defmodule Aly.FunnelView do
  use Aly.Web, :view

  def format_steps(steps) do
    steps
    |> Enum.map(fn(v) -> v["event"] end)
    |> Enum.join("\r\n")
  end

  def encode(steps) do
    Poison.encode!(steps)
  end
end
