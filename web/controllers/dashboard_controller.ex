defmodule Aly.DashboardController do
  use Aly.Web, :controller

  alias Aly.Funnel

  def index(conn, _params) do
    funnels = Repo.all(Funnel)
    render conn, "index.html", funnels: funnels
  end
end
