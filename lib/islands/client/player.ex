# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.Player do
  @moduledoc """
  Models a player in the _Game of Islands_.

  ##### Inspired by the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias Islands.Client.{GameOver, Input, Mover, React, State}
  alias Islands.Tally

  @doc """
  Reacts to a game state, makes a move and repeats until the game is over.

  Player1 reacts to game state:

  - `:initialized` by waiting for game state `:players_set`
  - `:players_set` by waiting for game state `:player1_turn`
  - `:player2_turn` by waiting for game state `:player1_turn` or `:game_over`
  - `:game_over` by exiting the game

  Player2 reacts to game state:

  - `:players_set` by waiting for game state `:player2_turn`
  - `:player1_turn` by waiting for game state `:player2_turn` or `:game_over`
  - `:game_over` by exiting the game
  """
  # :initialized, :players_set, :player1_turn, :player2_turn, :game_over
  @spec play(State.t()) :: no_return
  def play(%State{tally: %Tally{game_state: game_state}} = state) do
    React.react_to(state, game_state) |> continue()
  end

  def play(_error) do
    self() |> Process.exit(:normal)
  end

  ## Private functions

  @spec continue(State.t()) :: no_return
  defp continue(%State{tally: %Tally{game_state: :game_over}} = state) do
    # This player was notified of the `:game_over` game state.
    # The oppponent player caused the `:game_over` game state.
    GameOver.exit(state, end_game: false)
  end

  defp continue(state) do
    :ok = Tally.summary(state.tally, state.player_id)

    state
    |> Input.accept_move()
    |> Mover.make_move()
    |> play()
  end
end
