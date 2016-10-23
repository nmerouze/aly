defmodule Aly.ProjectControllerTest do
  use Aly.ConnCase, async: true

  alias Aly.{Repo, Event, Session, EventData}

  describe "create/2" do
    test "creates event and session", %{conn: conn} do
      data =
        %EventData{ event: "pageview", session_id: "befvon" }
        |> Poison.encode!
        |> Base.encode64

      response = post(conn, "/api/events", %{"data" => data})
      assert response.status == 201
      event = Repo.one!(Event)
      session = Repo.get!(Session, event.session_id)
      assert event.name == "pageview"
      assert session.client_id == "befvon"
      assert event.session_id == session.id
    end

    test "creates event with existing session", %{conn: conn} do
      session = Repo.insert!(Session.changeset(%Session{}, %{client_id: "befvon"}))

      data =
        %EventData{ event: "pageview", session_id: session.client_id }
        |> Poison.encode!
        |> Base.encode64

      response = post(conn, "/api/events", %{"data" => data})
      assert response.status == 201
      event = Repo.one!(Event)
      assert event.name == "pageview"
      assert event.session_id == session.id
    end

    test "fails", %{conn: conn} do
      data1 =
        %EventData{ session_id: "befvon", event: "" }
        |> Poison.encode!
        |> Base.encode64

      data2 =
        %EventData{ session_id: "", event: "pageview" }
        |> Poison.encode!
        |> Base.encode64

      response = post(conn, "/api/events", %{"data" => data1})
      assert response.status == 400
      response = post(conn, "/api/events", %{"data" => data2})
      assert response.status == 400
    end
  end
end
