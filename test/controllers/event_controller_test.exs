defmodule Aly.ProjectControllerTest do
  use Aly.ConnCase, async: true

  # import Aly.Factory
  alias Aly.{Repo, Event, Session}

  describe "create/2" do
    test "creates event and session", %{conn: conn} do
      params = %{
        session_id: "befvon",
        event: "pageview"
      }

      response = post(conn, "/api/events", params)
      assert response.status == 201
      event = Repo.one!(Event)
      session = Repo.get!(Session, event.session_id)
      assert event.name == "pageview"
      assert session.client_id == "befvon"
      assert event.session_id == session.id
    end

    test "creates event with existing session", %{conn: conn} do
      session = Repo.insert!(Session.changeset(%Session{}, %{client_id: "befvon"}))

      params = %{
        session_id: session.client_id,
        event: "pageview"
      }

      response = post(conn, "/api/events", params)
      assert response.status == 201
      event = Repo.one!(Event)
      assert event.name == "pageview"
      assert event.session_id == session.id
    end

    test "fails", %{conn: conn} do
      response = post(conn, "/api/events", %{ session_id: "befvon", event: "" })
      assert response.status == 400
      response = post(conn, "/api/events", %{ session_id: "", event: "pageview" })
      assert response.status == 400
    end
  end
end
