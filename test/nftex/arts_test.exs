defmodule Nftex.ArtsTest do
  use Nftex.DataCase, async: true

  alias Nftex.Art
  alias Nftex.Arts

  import Nftex.Factory

  describe "create/1" do
    test "when params are valid, creates the art" do
      params = build(:art_params)

      response = Arts.create(params)

      assert {:ok,
              %Art{
                id: _id,
                artist_name: "Artist #01",
                description: "Art #01",
                hash: "4577ca2cdf2500008a92c67bf80cb2af",
                price: 95.65
              }} = response
    end

    test "where there are invalid params, returns an error" do
      {:error, changeset} = Arts.create(%{})

      assert %{
               artist_name: ["can't be blank"],
               description: ["can't be blank"],
               hash: ["can't be blank"],
               price: ["can't be blank"]
             } == errors_on(changeset)
    end
  end

  describe "get/1" do
    test "when a valid id is given, returns the user" do
      %Art{id: id} = insert(:art)

      response = Arts.get(id)

      assert {:ok,
              %Art{
                id: _id,
                artist_name: "Artist #01",
                description: "Art #01",
                hash: "4577ca2cdf2500008a92c67bf80cb2af",
                price: 95.65
              }} = response
    end

    test "when the id is invalid, returns an error" do
      response = Arts.get("invalid_id")

      assert {:error, "Invalid UUID"} == response
    end
  end
end
