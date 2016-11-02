defmodule Aly.Public.UserController do
  use Aly.Web, :controller

  alias Aly.User

  @spec create(Plug.Conn.t, {String.t}) :: no_return
  def create(conn, %{"data" => data}) do
    user_data =
      data
      |> Base.decode64!
      |> Poison.decode!

    changeset = User.changeset(%User{}, user_data)

    case Repo.insert(changeset) do
      {:ok, _} -> send_resp(conn, 201, "")
      {:error, _} -> send_resp(conn, 400, "")
    end
  end
end
