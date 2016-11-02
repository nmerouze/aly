defmodule Aly.EventQueryTest do
  use Aly.ModelCase

  import Aly.Factory
  alias Aly.EventQuery

  describe "properties" do
    test "get all property keys from a set of events" do
      insert(:event, user_id: "1")
      insert(:event, user_id: "1")
      insert(:event, user_id: "1", properties: %{
        "title" => "test",
        "other_key" => "test"
      })

      assert Repo.all(EventQuery.properties) == ["other_key", "title"]
    end
  end
end
