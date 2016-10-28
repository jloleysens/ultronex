defmodule Ultronex.ScraperTest do
  use ExUnit.Case, async: true
  use Hound.Helpers

  setup do
    Hound.start_session
    :ok
  end

  test "Scripts dir is reachable" do
    assert {:ok, []} = Ultronex.Scraper.run_script("test.exs")
  end

  test "Can navigate" do
    navigate_to("https://www.google.co.za")
    assert page_title() == "Google"
  end
end
