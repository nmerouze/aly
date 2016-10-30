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

      assert EventQuery.funnel(funnel.steps) == %{
        "property" => %{"name" => "", "value" => "Overall"},
        "steps" => [%{"name" => "pageview", "value" => 2}, %{"name" => "signup", "value" => 1}]
      }
    end

    test "aggregates to have a default value to 0" do
      funnel = insert(:funnel)

      assert EventQuery.funnel(funnel.steps) == %{
        "property" => %{"name" => "", "value" => "Overall"},
        "steps" => [%{"name" => "pageview", "value" => 0}, %{"name" => "signup", "value" => 0}]
      }
    end

    test "aggregates events and groups by property" do
      funnel = insert(:funnel)
      session1 = insert(:session)
      session2 = insert(:session, client_id: "123abc")
      insert(:event, session: session1)
      insert(:event, name: "signup", session: session1)
      insert(:event, session: session2, properties: %{
        "title" => "test"
      })

      aggregates = EventQuery.funnel(funnel.steps, "title")
      assert length(aggregates) == 3
      assert Enum.at(aggregates, 0) == %{
        "property" => %{"name" => "", "value" => "Overall"},
        "steps" => [%{"name" => "pageview", "value" => 2}, %{"name" => "signup", "value" => 1}]
      }
      assert Enum.at(aggregates, 1) == %{
        "property" => %{"name" => "title", "value" => "foobar"},
        "steps" => [%{"name" => "pageview", "value" => 1}, %{"name" => "signup", "value" => 1}]
      }
      assert Enum.at(aggregates, 2) == %{
        "property" => %{"name" => "title", "value" => "test"},
        "steps" => [%{"name" => "pageview", "value" => 1}, %{"name" => "signup", "value" => 0}]
      }
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
