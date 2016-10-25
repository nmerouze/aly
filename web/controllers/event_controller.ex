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
      nil -> insert_session(conn, event_data)
      session -> insert_event(conn, Map.put(event_data, :session_id, session.id))
    end
  end

  @spec insert_event(Plug.Conn.t, EventData) :: no_return
  defp insert_event(conn, data) do
    changeset = Event.changeset(%Event{}, %{
      name: data.event,
      session_id: data.session_id,
      properties: data.properties
    })

    case Repo.insert(changeset) do
      {:ok, _} -> send_resp(conn, 201, "")
      {:error, _} -> send_resp(conn, 400, "")
    end
  end

  @spec insert_session(Plug.Conn.t, EventData) :: no_return
  defp insert_session(conn, data) do
    case Repo.insert(Session.changeset(%Session{}, %{client_id: data.session_id})) do
      {:ok, session} -> insert_event(conn, Map.put(data, :session_id, session.id))
      {:error, _} -> send_resp(conn, 400, "")
    end
  end
end
