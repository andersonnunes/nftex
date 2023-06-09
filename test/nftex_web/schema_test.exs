defmodule NftexWeb.SchemaTest do
  use NftexWeb.ConnCase, async: true

  alias Nftex.Art
  alias Nftex.Arts

  import Nftex.Factory

  describe "arts query" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{
        artist_name: "Artist #01",
        description: "Art #01",
        hash: "4577ca2cdf2500008a92c67bf80cb2af",
        price: 95.65
      }

      {:ok, %Art{id: id}} = Arts.create(params)

      query = """
       {
        art(id: "#{id}") {
          artist_name
          description
          hash
          price
        }
       }
      """

      expected_response = %{
        "data" => %{
          "art" => %{
            "artist_name" => "Artist #01",
            "description" => "Art #01",
            "hash" => "4577ca2cdf2500008a92c67bf80cb2af",
            "price" => 95.65
          }
        }
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == expected_response
    end

    test "when a valid query, returns the arts", %{conn: conn} do
      insert(:art)
      insert(:art, %{id: "c08e9cdb-ceed-4177-aa05-b87350a180a8"})

      query = """
       {
        arts {
          id
          artist_name
          description
          hash
          price
        }
       }
      """

      expected_response = %{
        "data" => %{
          "arts" => [
            %{
              "artist_name" => "Artist #01",
              "description" => "Art #01",
              "hash" => "4577ca2cdf2500008a92c67bf80cb2af",
              "id" => "7aa8b50d-4057-43aa-aeed-7d56bea90cb6",
              "price" => 95.65
            },
            %{
              "artist_name" => "Artist #01",
              "description" => "Art #01",
              "hash" => "4577ca2cdf2500008a92c67bf80cb2af",
              "id" => "c08e9cdb-ceed-4177-aa05-b87350a180a8",
              "price" => 95.65
            }
          ]
        }
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == expected_response
    end

    test "when the id is invalid, returns an error", %{conn: conn} do
      query = """
       {
        art(id: "invalid_id") {
          artist_name
          description
          hash
          price
        }
       }
      """

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 7, "line" => 2}],
            "message" => "Argument \"id\" has invalid value \"invalid_id\"."
          }
        ]
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == expected_response
    end

    test "when the art does not exist, returns an error", %{conn: conn} do
      query = """
       {
        art(id: "23bf9c70-85f9-49a2-a2f2-b15a59867621") {
          artist_name
          description
          hash
          price
        }
       }
      """

      expected_response = %{
        "data" => %{"art" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 3, "line" => 2}],
            "message" => "Art not found",
            "path" => ["art"]
          }
        ]
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert response == expected_response
    end
  end

  describe "arts mutation" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createsArt(input: {
            artistName: "Artist #01",
            description: "Art #01",
            hash: "4577ca2cdf2500008a92c67bf80cb2af",
            price: 90.50
          }) {
            artistName
            description
            hash
            price
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "createsArt" => %{
            "artistName" => "Artist #01",
            "description" => "Art #01",
            "hash" => "4577ca2cdf2500008a92c67bf80cb2af",
            "price" => 90.5
          }
        }
      }

      assert response == expected_response
    end
  end
end
