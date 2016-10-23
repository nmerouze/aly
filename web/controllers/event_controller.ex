defmodule Aly.EventController do
  use Aly.Web, :controller

  alias Aly.{Event, EventData, Session, SessionQuery}

  @spec create(Plug.Conn.t, {String.t}) :: no_return
  def create(conn, %{"data" => data}) do
    event_data =
      data
      |> Base.decode64!
      |> Poison.decode!(as: %EventData{})

    case Repo.one(SessionQuery.by_client_id(event_data.session_id)) do
      nil -> insert_session(conn, event_data.event, event_data.session_id)
      session -> insert_event(conn, event_data.event, session.id)
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
