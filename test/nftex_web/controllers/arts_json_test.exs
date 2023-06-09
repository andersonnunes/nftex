defmodule NftexWeb.ArtsJSONTest do
  use NftexWeb.ConnCase, async: true

  alias NftexWeb.ArtsJSON

  import Nftex.Factory

  test "renders index.json" do
    art = build(:art_params)

    response = ArtsJSON.index(%{data: %{arts: [art]}})

    expected_response = %{
      arts: [
        %{
          artist_name: "Artist #01",
          description: "Art #01",
          hash: "4577ca2cdf2500008a92c67bf80cb2af",
          price: 95.65
        }
      ]
    }

    assert expected_response == response
  end
end
