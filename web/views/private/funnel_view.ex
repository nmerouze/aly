defmodule Aly.Private.FunnelView do
  use Aly.Web, :view

  def render("show.json", %{data: data}) do
    %{data: data}
  end
end
