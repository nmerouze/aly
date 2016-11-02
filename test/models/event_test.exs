defmodule Aly.EventTest do
  use Aly.ModelCase

  alias Aly.Event

  @valid_attrs %{name: "foobar", user_id: "test"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
