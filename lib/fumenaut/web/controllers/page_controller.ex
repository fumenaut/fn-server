defmodule Fumenaut.Web.PageController do
  use Fumenaut.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
