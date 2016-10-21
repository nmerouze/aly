defmodule Aly.FunnelTest do
  use Aly.ModelCase

  alias Aly.Funnel

  @valid_attrs %{"name" => "foobar", "steps" => "pageview\r\nsignup"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Funnel.changeset(%Funnel{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Funnel.changeset(%Funnel{}, @invalid_attrs)
    refute changeset.valid?
  end
end
