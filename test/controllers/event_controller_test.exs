defmodule Aly.ProjectControllerTest do
  use Aly.ConnCase, async: true

  alias Aly.{Repo, Event, EventData}

  describe "create/2" do
    test "creates event and session", %{conn: conn} do
      data =
        %EventData{event: "pageview", user_id: "befvon", properties: %{title: "foobar"}}
        |> Poison.encode!
        |> Base.encode64

      response = post(conn, "/api/events", %{"data" => data})
      assert response.status == 201
      event = Repo.one!(Event)
      assert event.name == "pageview"
      assert event.user_id == "befvon"
      assert event.properties == %{"title" => "foobar"}
    end

    test "fails", %{conn: conn} do
      data1 =
        %EventData{user_id: "befvon", event: ""}
        |> Poison.encode!
        |> Base.encode64

      data2 =
        %EventData{user_id: "", event: "pageview"}
        |> Poison.encode!
        |> Base.encode64

      response = post(conn, "/api/events", %{"data" => data1})
      assert response.status == 400
      response = post(conn, "/api/events", %{"data" => data2})
      assert response.status == 400
    end
  end
end
