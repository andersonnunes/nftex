defmodule Nftex.ArtTest do
  use Nftex.DataCase, async: true

  alias Ecto.Changeset
  alias Nftex.Art

  import Nftex.Factory

  describe "changeset/1" do
    test "when params are valid, returns a valid changeset" do
      params = build(:art_params)

      response = Art.changeset(params)

      assert %Changeset{
               changes: %{description: "Art #01"},
               valid?: true
             } = response
    end

    test "when there are some error, returns an invalid changeset" do
      response = Art.changeset(%{})

      expected_response = %{
        description: ["can't be blank"],
        price: ["can't be blank"],
        artist_name: ["can't be blank"],
        hash: ["can't be blank"]
      }

      assert expected_response == errors_on(response)
    end
  end
end
