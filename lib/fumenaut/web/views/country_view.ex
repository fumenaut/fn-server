defmodule Fumenaut.Web.CountryView do
  use Fumenaut.Web, :view
  alias Fumenaut.Web.CountryView

  def render("index.json", %{countries: countries}) do
    %{data: render_many(countries, CountryView, "country.json")}
  end

  def render("show.json", %{country: country}) do
    %{data: render_one(country, CountryView, "country.json")}
  end

  def render("country.json", %{country: country}) do
    %{id: country.id,
      name: country.name}
  end
end
