defmodule Ultronex.Mixfile do
  use Mix.Project

  def project do
    [app: :ultronex,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :hound, :timex],
      mod: {Ultronex, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # HTML/node traversal
      {:floki, "~> 0.10.1"},
      # For PhantomJS
      {:hound, "~> 1.0.1"},
      # JSON stuff!
      {:poison, "~> 2.0"},
      # Let's go on a journey... A journey through all time!
      {:timex, "~>3.0"}
    ]
  end
end
