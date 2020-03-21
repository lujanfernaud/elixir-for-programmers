defmodule Hangman.Game do
  # A struct is a named map. It is static (you can't add or remove keys).
  # It is named the same as the module on which it is defined.
  # We could call it like %Hangman.Game{}
  #
  # Example:
  #
  #   > %Hangman.Game{}
  #   %Hangman.Game{game_state: :initializing, turns_left: 7}
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game do
    %Hangman.Game{
      letters: Dictionary.random_word() |> String.codepoints()
    }
  end

  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    {game, tally(game)}
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    {game, tally(game)}
  end

  def accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
  end

  def tally(_game) do
    123
  end
end
