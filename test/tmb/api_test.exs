defmodule Tmb.ApiTest do
  use ExUnit.Case
  doctest Tmb

  import Tesla.Mock

  alias Tmb.{Api, Ibus}

  @query [app_id: System.get_env("TMB_APP_ID"), app_key: System.get_env("TMB_APP_KEY")]
  @mocked_body %{
    "data" => %{
      "ibus" => [
        %{
          "destination" => "Disneyland",
          "line" => "PCE",
          "routeId" => "ring",
          "text-ca" => "molts min",
          "t-in-min" => 99,
          "t-in-s" => 99 * 60
        }
      ]
    }
  }

  setup do
    mock fn
      %{method: :get, url: "https://api.tmb.cat/v1/ibus/stops/3714", query: @query} -> json(@mocked_body)
      %{method: :get, url: "https://api.tmb.cat/v1/ibus/lines/V1/stops/3714", query: @query} -> json(@mocked_body)
    end

    :ok
  end

  test "stop/1" do
    [result | _] = Api.stop("3714")

    assert %Ibus{
      destination: "Disneyland",
      line: "PCE",
      route_id: "ring",
      text_ca: "molts min",
      time_in_min: 99,
      time_in_seconds: 5_940
    } == result
  end

  test "stop/2" do
    [result | _] = Api.stop("3714", "V1")
    assert %Ibus{
      destination: "Disneyland",
      line: "PCE",
      route_id: "ring",
      text_ca: "molts min",
      time_in_min: 99,
      time_in_seconds: 5_940
    } == result
  end
end
