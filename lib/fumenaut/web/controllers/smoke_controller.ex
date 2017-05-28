defmodule Fumenaut.Web.SmokeController do
  use Fumenaut.Web, :controller

  alias Fumenaut.Journal
  alias Fumenaut.Journal.Smoke

  action_fallback Fumenaut.Web.FallbackController

  def index(conn, _params) do
    smokes = Journal.list_smokes()
    render(conn, "index.json", smokes: smokes)
  end

  def create(conn, %{"smoke" => smoke_params}) do
    with {:ok, %Smoke{} = smoke} <- Journal.create_smoke(smoke_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", smoke_path(conn, :show, smoke))
      |> render("show.json", smoke: smoke)
    end
  end

  def show(conn, %{"id" => id}) do
    smoke = Journal.get_smoke!(id)
    render(conn, "show.json", smoke: smoke)
  end

  def update(conn, %{"id" => id, "smoke" => smoke_params}) do
    smoke = Journal.get_smoke!(id)

    with {:ok, %Smoke{} = smoke} <- Journal.update_smoke(smoke, smoke_params) do
      render(conn, "show.json", smoke: smoke)
    end
  end

  def delete(conn, %{"id" => id}) do
    smoke = Journal.get_smoke!(id)
    with {:ok, %Smoke{}} <- Journal.delete_smoke(smoke) do
      send_resp(conn, :no_content, "")
    end
  end
end
