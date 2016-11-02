defmodule Aly.FunnelQueryTest do
  use Aly.ModelCase

  import Aly.Factory
  alias Aly.FunnelQuery

  describe "funnel" do
    test "aggregates events for each funnel step" do
      funnel = insert(:funnel)
      insert(:event, user_id: "1")
      insert(:event, name: "signup", user_id: "1")
      insert(:event, user_id: "2")

      assert FunnelQuery.data(funnel.steps) == %{
        "property" => %{"name" => "", "value" => "Overall"},
        "steps" => [%{"name" => "pageview", "value" => 2}, %{"name" => "signup", "value" => 1}]
      }
    end

    test "aggregates to have a default value to 0" do
      funnel = insert(:funnel)

      assert FunnelQuery.data(funnel.steps) == %{
        "property" => %{"name" => "", "value" => "Overall"},
        "steps" => [%{"name" => "pageview", "value" => 0}, %{"name" => "signup", "value" => 0}]
      }
    end

    test "aggregates events and groups by property" do
      funnel = insert(:funnel)
      insert(:event, user_id: "1")
      insert(:event, name: "signup", user_id: "1")
      insert(:event, user_id: "2", properties: %{
        "title" => "test"
      })

      aggregates = FunnelQuery.data(funnel.steps, "title")
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
end
