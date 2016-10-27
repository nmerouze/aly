defmodule Aly.FunnelController do
  use Aly.Web, :controller

  alias Aly.{Funnel, EventQuery}

  def new(conn, _params) do
    changeset = Funnel.changeset(%Funnel{}, %{steps: []})
    render conn, "new.html", changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    funnel = Repo.get!(Funnel, id)
    steps = EventQuery.funnel(funnel.steps)
    properties = Repo.all(EventQuery.properties)
    render conn, "show.html", funnel: funnel, steps: steps, properties: properties
  end

  def create(conn, %{"funnel" => funnel}) do
    changeset = Funnel.changeset(%Funnel{}, funnel)

    case Repo.insert(changeset) do
      {:ok, _} ->
        redirect conn, to: "/"
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
