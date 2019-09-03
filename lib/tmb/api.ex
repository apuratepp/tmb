defmodule Tmb.Api do
  use Tesla

  alias Tmb.Ibus

  plug Tesla.Middleware.BaseUrl, "https://api.tmb.cat/v1/ibus"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Query, [app_id: System.get_env("TMB_APP_ID"), app_key: System.get_env("TMB_APP_KEY")]

  def stop(stop_id) do
    get("/stops/#{stop_id}")
    |> handle_response
  end

  def stop(stop_id, line_id) do
    get("/lines/#{line_id}/stops/#{stop_id}")
    |> handle_response
  end

  defp handle_response({:ok, env}) do
    Ibus.new(env.body["data"]["ibus"])
  end
end
