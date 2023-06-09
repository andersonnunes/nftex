defmodule Nftex.Factory do
  use ExMachina.Ecto, repo: Nftex.Repo

  alias Nftex.Art

  def art_params_factory do
    %{
      artist_name: "Artist #01",
      description: "Art #01",
      hash: "4577ca2cdf2500008a92c67bf80cb2af",
      price: 95.65
    }
  end

  def art_factory do
    %Art{
      id: "7aa8b50d-4057-43aa-aeed-7d56bea90cb6",
      artist_name: "Artist #01",
      description: "Art #01",
      hash: "4577ca2cdf2500008a92c67bf80cb2af",
      price: 95.65
    }
  end
end
