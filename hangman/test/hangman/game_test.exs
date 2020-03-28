defmodule Hangman.GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)

      assert {game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    moves = [
      {"w", :good_guess, 7}
    ]

    game = Game.new_game("wibble")

    assert_game_moves(moves, game)
  end

  test "second occurrence of letter is already used" do
    moves = [
      {"w", :good_guess, 7},
      {"w", :already_used, 7}
    ]

    game = Game.new_game("wibble")

    assert_game_moves(moves, game)
  end

  test "a good guess is recognized" do
    moves = [
      {"w", :good_guess, 7}
    ]

    game = Game.new_game("wibble")

    assert_game_moves(moves, game)
  end

  test "a guessed word is a won game" do
    moves = [
      {"w", :good_guess, 7},
      {"i", :good_guess, 7},
      {"b", :good_guess, 7},
      {"l", :good_guess, 7},
      {"e", :won, 7}
    ]

    game = Game.new_game("wibble")

    assert_game_moves(moves, game)
  end

  test "bad guess is recognized" do
    moves = [
      {"a", :bad_guess, 6}
    ]

    game = Game.new_game("wibble")

    assert_game_moves(moves, game)
  end

  test "game state is set to 'lost' if bad guess happens on the last turn" do
    moves = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"c", :bad_guess, 4},
      {"d", :bad_guess, 3},
      {"e", :bad_guess, 2},
      {"f", :bad_guess, 1},
      {"g", :lost, 1}
    ]

    game = Game.new_game("w")

    assert_game_moves(moves, game)
  end

  defp assert_game_moves(moves, game) do
    Enum.reduce(moves, game, fn {guess, state, turns_left}, new_game ->
      {new_game, _tally} = Game.make_move(new_game, guess)
      assert {guess, new_game.game_state, new_game.turns_left} == {guess, state, turns_left}
      new_game
    end)
  end
end
