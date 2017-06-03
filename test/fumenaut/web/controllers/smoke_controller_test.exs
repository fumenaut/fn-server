defmodule Fumenaut.Web.SmokeControllerTest do
  use Fumenaut.Web.ConnCase

  alias Fumenaut.Journal
  alias Fumenaut.Journal.Smoke

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  def fixture(:smoke) do
    {:ok, smoke} = Journal.create_smoke(@create_attrs)
    smoke
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, smoke_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates smoke and renders smoke when data is valid", %{conn: conn} do
    conn = post conn, smoke_path(conn, :create), smoke: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, smoke_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "body" => "some body",
      "title" => "some title"}
  end

  test "does not create smoke and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, smoke_path(conn, :create), smoke: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen smoke and renders smoke when data is valid", %{conn: conn} do
    %Smoke{id: id} = smoke = fixture(:smoke)
    conn = put conn, smoke_path(conn, :update, smoke), smoke: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, smoke_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "body" => "some updated body",
      "title" => "some updated title"}
  end

  test "does not update chosen smoke and renders errors when data is invalid", %{conn: conn} do
    smoke = fixture(:smoke)
    conn = put conn, smoke_path(conn, :update, smoke), smoke: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen smoke", %{conn: conn} do
    smoke = fixture(:smoke)
    conn = delete conn, smoke_path(conn, :delete, smoke)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, smoke_path(conn, :show, smoke)
    end
  end
end
