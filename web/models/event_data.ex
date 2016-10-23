defmodule Aly.EventData do
  @derive [Poison.Encoder]
  defstruct [:event, :session_id]
end
