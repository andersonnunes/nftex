defmodule NftexWeb.ArtsControllerTest do
  use NftexWeb.ConnCase, async: true

  import Nftex.Factory

  test "returns arts", %{conn: conn} do
    insert(:art)

    expected_response = %{
      "arts" => [
        %{
          "artist_name" => "Artist #01",
          "description" => "Art #01",
          "hash" => "4577ca2cdf2500008a92c67bf80cb2af",
          "id" => "7aa8b50d-4057-43aa-aeed-7d56bea90cb6"
        }
      ]
    }

    response =
      conn
      |> get("/api/arts/")
      |> json_response(:ok)

    assert expected_response == response
  end
end
