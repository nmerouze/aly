defmodule Aly.EventData do
  @derive [Poison.Encoder]
  defstruct [:event, :user_id, :properties]
end
