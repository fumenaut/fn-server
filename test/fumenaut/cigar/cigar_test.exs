defmodule Fumenaut.CigarTest do
  use Fumenaut.DataCase

  alias Fumenaut.Cigar

  describe "countries" do
    alias Fumenaut.Cigar.Country

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def country_fixture(attrs \\ %{}) do
      {:ok, country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cigar.create_country()

      country
    end

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Cigar.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Cigar.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      assert {:ok, %Country{} = country} = Cigar.create_country(@valid_attrs)
      assert country.name == "some name"
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cigar.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      assert {:ok, country} = Cigar.update_country(country, @update_attrs)
      assert %Country{} = country
      assert country.name == "some updated name"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Cigar.update_country(country, @invalid_attrs)
      assert country == Cigar.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Cigar.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Cigar.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Cigar.change_country(country)
    end
  end
end
