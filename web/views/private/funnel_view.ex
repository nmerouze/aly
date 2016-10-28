defmodule Aly.Private.FunnelView do
  use Aly.Web, :view

  def render("show.json", %{properties: properties}) do
    %{data: properties}
  end
end
