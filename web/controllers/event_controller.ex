defmodule Aly.EventController do
  use Aly.Web, :controller

  alias Aly.Event
  alias Aly.Session
  alias Aly.SessionQuery

  @spec create(Plug.Conn.t, {String.t, String.t}) :: no_return
  def create(conn, %{"session_id" => client_id, "event" => event}) do
    case Repo.one(SessionQuery.by_client_id(client_id)) do
      nil -> insert_session(conn, event, client_id)
      session -> insert_event(conn, event, session.id)
    end
  end

  @spec insert_event(Plug.Conn.t, String.t, integer) :: no_return
  defp insert_event(conn, event, session_id) do
    changeset = Event.changeset(%Event{}, %{
      name: event,
      session_id: session_id
    })

    case Repo.insert(changeset) do
      {:ok, _} -> send_resp(conn, 201, "")
      {:error, _} -> send_resp(conn, 400, "")
    end
  end

  @spec insert_session(Plug.Conn.t, String.t, String.t) :: no_return
  defp insert_session(conn, event, client_id) do
    case Repo.insert(Session.changeset(%Session{}, %{client_id: client_id})) do
      {:ok, session} -> insert_event(conn, event, session.id)
      {:error, _} -> send_resp(conn, 400, "")
    end
  end
end
