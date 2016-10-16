defmodule Aly.EventController do
  use Aly.Web, :controller

  alias Aly.Event
  alias Aly.Session
  alias Aly.SessionQuery

  def create(conn, params) do
    session_id = case Repo.one(SessionQuery.by_client_id(params["session_id"])) do
      nil ->
        Repo.insert!(Session.changeset(%Session{}, %{client_id: params["session_id"]})).id
      record ->
        record.id
    end

    attrs = %{
      name: params["event"],
      session_id: session_id
    }

    changeset = Event.changeset(%Event{}, attrs)

    case Repo.insert(changeset) do
      {:ok, _} ->
        send_resp(conn, 201, "")
      {:error, _} ->
        send_resp(conn, 400, "")
    end
  end
end
