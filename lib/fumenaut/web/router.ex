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

  pipeline :graphql do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Fumenaut.Web.Context
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

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: Fumenaut.Schema
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Fumenaut.Schema
end
