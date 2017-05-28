defmodule Fumenaut.JournalTest do
  use Fumenaut.DataCase

  alias Fumenaut.Journal

  describe "smokes" do
    alias Fumenaut.Journal.Smoke

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def smoke_fixture(attrs \\ %{}) do
      {:ok, smoke} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journal.create_smoke()

      smoke
    end

    test "list_smokes/0 returns all smokes" do
      smoke = smoke_fixture()
      assert Journal.list_smokes() == [smoke]
    end

    test "get_smoke!/1 returns the smoke with given id" do
      smoke = smoke_fixture()
      assert Journal.get_smoke!(smoke.id) == smoke
    end

    test "create_smoke/1 with valid data creates a smoke" do
      assert {:ok, %Smoke{} = smoke} = Journal.create_smoke(@valid_attrs)
      assert smoke.body == "some body"
      assert smoke.title == "some title"
    end

    test "create_smoke/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journal.create_smoke(@invalid_attrs)
    end

    test "update_smoke/2 with valid data updates the smoke" do
      smoke = smoke_fixture()
      assert {:ok, smoke} = Journal.update_smoke(smoke, @update_attrs)
      assert %Smoke{} = smoke
      assert smoke.body == "some updated body"
      assert smoke.title == "some updated title"
    end

    test "update_smoke/2 with invalid data returns error changeset" do
      smoke = smoke_fixture()
      assert {:error, %Ecto.Changeset{}} = Journal.update_smoke(smoke, @invalid_attrs)
      assert smoke == Journal.get_smoke!(smoke.id)
    end

    test "delete_smoke/1 deletes the smoke" do
      smoke = smoke_fixture()
      assert {:ok, %Smoke{}} = Journal.delete_smoke(smoke)
      assert_raise Ecto.NoResultsError, fn -> Journal.get_smoke!(smoke.id) end
    end

    test "change_smoke/1 returns a smoke changeset" do
      smoke = smoke_fixture()
      assert %Ecto.Changeset{} = Journal.change_smoke(smoke)
    end
  end
end
