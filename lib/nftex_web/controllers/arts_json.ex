defmodule NftexWeb.ArtsJSON do
  def index(%{data: %{arts: arts}}) do
    %{arts: arts}
  end
end
