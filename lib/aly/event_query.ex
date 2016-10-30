defmodule Aly.EventQuery do
  import Ecto.Query, only: [from: 2]
  alias Aly.Event

  def properties do
    from e in Event,
      select: fragment("DISTINCT jsonb_object_keys(?)", e.properties)
  end
end
