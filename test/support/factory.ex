defmodule Aly.Factory do
  use ExMachina.Ecto, repo: Aly.Repo

  def funnel_factory do
    %Aly.Funnel{
      name: "Test",
      steps: [
        %{"event" => "pageview"},
        %{"event" => "signup"}
      ]
    }
  end

  def event_factory do
    %Aly.Event{
      name: "pageview",
      properties: %{
        "title" => "foobar"
      }
    }
  end
end
