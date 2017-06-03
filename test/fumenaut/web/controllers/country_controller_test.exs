defmodule Fumenaut.Web.CountryControllerTest do
  use Fumenaut.Web.ConnCase

  alias Fumenaut.Cigar
  alias Fumenaut.Cigar.Country

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:country) do
    {:ok, country} = Cigar.create_country(@create_attrs)
    country
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, country_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates country and renders country when data is valid", %{conn: conn} do
    conn = post conn, country_path(conn, :create), country: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, country_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name"}
  end

  test "does not create country and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, country_path(conn, :create), country: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen country and renders country when data is valid", %{conn: conn} do
    %Country{id: id} = country = fixture(:country)
    conn = put conn, country_path(conn, :update, country), country: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, country_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name"}
  end

  test "does not update chosen country and renders errors when data is invalid", %{conn: conn} do
    country = fixture(:country)
    conn = put conn, country_path(conn, :update, country), country: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen country", %{conn: conn} do
    country = fixture(:country)
    conn = delete conn, country_path(conn, :delete, country)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, country_path(conn, :show, country)
    end
  end
end
