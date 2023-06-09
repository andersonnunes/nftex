defmodule Nftex.Arts.CreateTest do
  use Nftex.DataCase, async: true

  alias Nftex.Art
  alias Nftex.Arts.Create

  import Nftex.Factory

  describe "call/1" do
    test "when params are valid, creates the art" do
      params = build(:art_params)

      response = Create.call(params)

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
      {:error, changeset} = Create.call(%{})

      assert %{
               artist_name: ["can't be blank"],
               description: ["can't be blank"],
               hash: ["can't be blank"],
               price: ["can't be blank"]
             } == errors_on(changeset)
    end
  end
end
