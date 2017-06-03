defmodule Fumenaut.Web.ManufacturerController do
  use Fumenaut.Web, :controller

  alias Fumenaut.Cigar
  alias Fumenaut.Cigar.Manufacturer

  action_fallback Fumenaut.Web.FallbackController

  def index(conn, _params) do
    manufacturers = Cigar.list_manufacturers()
    render(conn, "index.json", manufacturers: manufacturers)
  end

  def create(conn, %{"manufacturer" => manufacturer_params}) do
    with {:ok, %Manufacturer{} = manufacturer} <- Cigar.create_manufacturer(manufacturer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", manufacturer_path(conn, :show, manufacturer))
      |> render("show.json", manufacturer: manufacturer)
    end
  end

  def show(conn, %{"id" => id}) do
    manufacturer = Cigar.get_manufacturer!(id)
    render(conn, "show.json", manufacturer: manufacturer)
  end

  def update(conn, %{"id" => id, "manufacturer" => manufacturer_params}) do
    manufacturer = Cigar.get_manufacturer!(id)

    with {:ok, %Manufacturer{} = manufacturer} <- Cigar.update_manufacturer(manufacturer, manufacturer_params) do
      render(conn, "show.json", manufacturer: manufacturer)
    end
  end

  def delete(conn, %{"id" => id}) do
    manufacturer = Cigar.get_manufacturer!(id)
    with {:ok, %Manufacturer{}} <- Cigar.delete_manufacturer(manufacturer) do
      send_resp(conn, :no_content, "")
    end
  end
end
