defmodule Tmb.Ibus do
  defstruct [
    :destination,
    :line,
    :route_id,
    :time_in_min,
    :time_in_seconds,
    :text_ca
  ]

  def new(params) when is_map(params) do
    %__MODULE__{
      destination: params["destination"],
      line: params["line"],
      route_id: params["routeId"],
      time_in_min: params["t-in-min"],
      time_in_seconds: params["t-in-s"],
      text_ca: params["text-ca"]
    }
  end

  def new(params) when is_list(params) do
    Enum.map(params, &new/1)
  end
end
