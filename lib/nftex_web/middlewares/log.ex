defmodule NftexWeb.Middlewares.Log do
  require Logger

  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    Logger.info(resolution.value)
    resolution
  end
end
