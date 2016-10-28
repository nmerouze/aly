defmodule Aly.Router do
  use Aly.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Aly do
    pipe_through :browser # Use the default browser stack

    get "/", DashboardController, :index
    resources "/funnels", FunnelController
  end

  scope "/private", Aly do
    pipe_through :api

    get "/funnels/:id", Private.FunnelController, :show
  end

  scope "/api", Aly do
    pipe_through :api

    post "/events", EventController, :create
  end
end
