defmodule Nftex.Arts.GetTest do
  use Nftex.DataCase, async: true

  alias Nftex.Art
  alias Nftex.Arts.Get

  import Nftex.Factory

  describe "call/1" do
    test "when there is an art with the given id, returns the art" do
      %Art{id: id} = insert(:art)

      response = Get.call(id)

      assert {:ok,
              %Art{
                id: _id,
                artist_name: "Artist #01",
                description: "Art #01",
                hash: "4577ca2cdf2500008a92c67bf80cb2af",
                price: 95.65
              }} = response
    end

    test "when there is a art with the invalid id, returns the error" do
      response = Get.call("invalid_id")

      assert {:error, "Invalid UUID"} == response
    end

    test "when art is not exists, returns the error" do
      response = Get.call("70359328-a4bb-4d4d-9df9-2993ecee6f49")

      assert {:error, "Art not found"} == response
    end
  end
end
