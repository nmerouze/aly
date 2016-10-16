defmodule Aly.FunnelController do
  use Aly.Web, :controller

  alias Aly.Funnel
  alias Aly.EventQuery

  def new(conn, _params) do
    changeset = Funnel.changeset(%Funnel{}, %{steps: []})
    render conn, "new.html", changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    funnel = Repo.get!(Funnel, id)

    steps =
      EventQuery.funnel(funnel.steps)
      |> Enum.with_index
      |> Enum.map(fn({v, i}) -> %{number: i + 1, name: Enum.at(funnel.steps, i)["event"], count: v} end)

    render conn, "show.html", funnel: funnel, steps: steps
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
