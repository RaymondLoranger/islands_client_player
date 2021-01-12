# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.Player do
  @moduledoc """
  Models a `player` in the _Game of Islands_.

  ##### Inspired by the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.{GameOver, Input, Mover, React, State, Summary}
  alias Islands.Tally

  # :initialized, :players_set, :player1_turn, :player2_turn, :game_over
  @spec play(State.t()) :: no_return
  def play(%State{tally: %Tally{game_state: game_state}} = state),
    do: React.react_to(state, game_state) |> continue()

  ## Private functions

  @spec continue(State.t()) :: no_return
  defp continue(%State{tally: %Tally{game_state: :game_over}} = state) do
    Summary.display(state) |> GameOver.message() |> ANSI.puts()
    GameOver.clear_messages()
    self() |> Process.exit(:normal)
  end

  defp continue(state) do
    state
    |> Summary.display()
    |> Input.accept_move()
    |> Mover.make_move()
    |> play()
  end
end
