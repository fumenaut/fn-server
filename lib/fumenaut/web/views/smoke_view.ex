defmodule Fumenaut.Web.SmokeView do
  use Fumenaut.Web, :view
  alias Fumenaut.Web.SmokeView

  def render("index.json", %{smokes: smokes}) do
    %{data: render_many(smokes, SmokeView, "smoke.json")}
  end

  def render("show.json", %{smoke: smoke}) do
    %{data: render_one(smoke, SmokeView, "smoke.json")}
  end

  def render("smoke.json", %{smoke: smoke}) do
    %{id: smoke.id,
      title: smoke.title,
      body: smoke.body}
  end
end
