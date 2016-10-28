defmodule Ultronex.RegistryTest do
  use ExUnit.Case, async: true

  # setup context do
  #   {:ok, registry } = Ultronex.Registry.start_link(context.test)
  #   {:ok, registry: registry }
  # end

  # test "Spawn scraper and remove on exit", %{registry: registry} do
  #   assert Ultronex.Registry.lookup(registry, "takealot.com") == :error

  #   Ultronex.Registry.create(registry, "takealot.com")
  #   assert {:ok, _} = Ultronex.Registry.lookup(registry, "takealot.com")

  #   :timer.sleep(500)

  #   # Just while the scraper is not doing anything... yet
  #   assert Ultronex.Registry.lookup(registry, "takealot.com") == :error

  # end

end
