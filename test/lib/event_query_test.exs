defmodule Aly.EventQueryTest do
  use Aly.ModelCase

  import Aly.Factory
  alias Aly.EventQuery

  describe "properties" do
    test "get all property keys from a set of events" do
      session = insert(:session)
      insert(:event, session: session)
      insert(:event, session: session)
      insert(:event, session: session, properties: %{
        "title" => "test",
        "other_key" => "test"
      })

      assert Repo.all(EventQuery.properties) == ["other_key", "title"]
    end
  end
end
