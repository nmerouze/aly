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
  end
end
