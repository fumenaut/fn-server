defmodule Fumenaut.Web.CountryController do
  use Fumenaut.Web, :controller

  alias Fumenaut.Cigar
  alias Fumenaut.Cigar.Country

  action_fallback Fumenaut.Web.FallbackController

  def index(conn, _params) do
    countries = Cigar.list_countries()
    render(conn, "index.json", countries: countries)
  end

  def create(conn, %{"country" => country_params}) do
    with {:ok, %Country{} = country} <- Cigar.create_country(country_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", country_path(conn, :show, country))
      |> render("show.json", country: country)
    end
  end

  def show(conn, %{"id" => id}) do
    country = Cigar.get_country!(id)
    render(conn, "show.json", country: country)
  end

  def update(conn, %{"id" => id, "country" => country_params}) do
    country = Cigar.get_country!(id)

    with {:ok, %Country{} = country} <- Cigar.update_country(country, country_params) do
      render(conn, "show.json", country: country)
    end
  end

  def delete(conn, %{"id" => id}) do
    country = Cigar.get_country!(id)
    with {:ok, %Country{}} <- Cigar.delete_country(country) do
      send_resp(conn, :no_content, "")
    end
  end
end
