defmodule Fumenaut.Web.ManufacturerControllerTest do
  use Fumenaut.Web.ConnCase

  alias Fumenaut.Cigar
  alias Fumenaut.Cigar.Manufacturer

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:manufacturer) do
    {:ok, manufacturer} = Cigar.create_manufacturer(@create_attrs)
    manufacturer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, manufacturer_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates manufacturer and renders manufacturer when data is valid", %{conn: conn} do
    conn = post conn, manufacturer_path(conn, :create), manufacturer: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, manufacturer_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name"}
  end

  test "does not create manufacturer and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, manufacturer_path(conn, :create), manufacturer: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen manufacturer and renders manufacturer when data is valid", %{conn: conn} do
    %Manufacturer{id: id} = manufacturer = fixture(:manufacturer)
    conn = put conn, manufacturer_path(conn, :update, manufacturer), manufacturer: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, manufacturer_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name"}
  end

  test "does not update chosen manufacturer and renders errors when data is invalid", %{conn: conn} do
    manufacturer = fixture(:manufacturer)
    conn = put conn, manufacturer_path(conn, :update, manufacturer), manufacturer: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen manufacturer", %{conn: conn} do
    manufacturer = fixture(:manufacturer)
    conn = delete conn, manufacturer_path(conn, :delete, manufacturer)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, manufacturer_path(conn, :show, manufacturer)
    end
  end
end
