defmodule Aly.Public.UserControllerTest do
  use Aly.ConnCase, async: true

  alias Aly.{Repo, User}

  describe "create/2" do
    test "creates user", %{conn: conn} do
      data =
        %{id: "foobar"}
        |> Poison.encode!
        |> Base.encode64

      response = post(conn, "/api/users", %{"data" => data})
      assert response.status == 201
      user = Repo.one!(User)
      assert user.id == "foobar"
    end

    test "fails", %{conn: conn} do
      data =
        %{}
        |> Poison.encode!
        |> Base.encode64

      response = post(conn, "/api/users", %{"data" => data})
      assert response.status == 400
    end
  end
end
