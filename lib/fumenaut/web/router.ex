defmodule Fumenaut.Web.Router do
  @moduledoc """
  Fumenaut web router.
  """

  use Fumenaut.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    resources "/users", UserController, except: [:new, :edit]
    resources "/smokes", SmokeController, except: [:new, :edit]
  end

  scope "/", Fumenaut.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  forward "/api", Absinthe.Plug, schema: Fumenaut.Schema
  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Fumenaut.Schema
end
