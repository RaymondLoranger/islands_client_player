defmodule Islands.Client.Player.MixProject do
  use Mix.Project

  def project do
    [
      app: :islands_client_player,
      version: "0.1.42",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Islands Client Player",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/islands_client_player"
  end

  defp description do
    """
    Models a player in the Game of Islands.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:io_ansi_plus, "~> 0.1"},
      {:islands_client_game_over, "~> 0.1"},
      {:islands_client_input, "~> 0.1"},
      {:islands_client_mover, "~> 0.1"},
      {:islands_client_react, "~> 0.1"},
      {:islands_client_state, "~> 0.1"},
      {:islands_tally, "~> 0.1"}
    ]
  end
end
