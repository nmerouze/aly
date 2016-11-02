defmodule Aly.EventController do
  use Aly.Web, :controller

  alias Aly.{Event, EventData}

  @spec create(Plug.Conn.t, {String.t}) :: no_return
  def create(conn, %{"data" => data}) do
    event_data =
      data
      |> Base.decode64!
      |> Poison.decode!(as: %EventData{})

    changeset = Event.changeset(%Event{}, %{
      name: event_data.event,
      user_id: event_data.user_id,
      properties: event_data.properties
    })

    case Repo.insert(changeset) do
      {:ok, _} -> send_resp(conn, 201, "")
      {:error, _} -> send_resp(conn, 400, "")
    end
  end
end
