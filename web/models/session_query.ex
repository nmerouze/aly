defmodule Aly.SessionQuery do
  import Ecto.Query
  alias Aly.Session

  def by_client_id(id) do
    Session
    |> where([s], s.client_id == ^id)
  end
end
