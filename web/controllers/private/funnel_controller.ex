defmodule Aly.Private.FunnelController do
  use Aly.Web, :controller

  alias Aly.{Funnel, FunnelQuery}

  def show(conn, %{"id" => id, "property" => property}) do
    funnel = Repo.get!(Funnel, id)
    data = FunnelQuery.data(funnel.steps, property)
    render conn, "show.json", data: data
  end
end
