defmodule Tmb.ApiTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Tmb

  alias Tmb.Api

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")

    :ok
  end

  test "stop/1" do
    use_cassette "stop1" do
      assert is_list(Api.stop("3714"))
    end
  end

  test "stop/2" do
    use_cassette "stop2" do
      assert is_list(Api.stop("3741", "V1"))
    end
  end
end
