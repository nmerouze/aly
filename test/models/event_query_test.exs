defmodule Aly.EventQueryTest do
  use Aly.ModelCase

  import Aly.Factory
  alias Aly.EventQuery

  describe "funnel" do
    test "aggregates events for each funnel step" do
      funnel = insert(:funnel)
      session1 = insert(:session)
      session2 = insert(:session, client_id: "123abc")
      insert(:event, session: session1)
      insert(:event, name: "signup", session: session1)
      insert(:event, session: session2)

      aggregates = EventQuery.funnel(funnel.steps)
      assert length(aggregates) == 2
      assert Enum.at(aggregates, 0) == %{number: 1, name: "pageview", count: 2}
      assert Enum.at(aggregates, 1) == %{number: 2, name: "signup", count: 1}
    end

    test "aggregates to have a default count to 0" do
      funnel = insert(:funnel)

      aggregates = EventQuery.funnel(funnel.steps)
      assert length(aggregates) == 2
      assert Enum.at(aggregates, 0) == %{number: 1, name: "pageview", count: 0}
      assert Enum.at(aggregates, 1) == %{number: 2, name: "signup", count: 0}
    end
  end

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
