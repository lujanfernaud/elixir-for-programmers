defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.Views.Helper.GameStateHelper

  def turn(turns_left, target) when target >= turns_left do
    "opacity: 1"
  end

  def turn(_turns_left, _target) do
    "opacity: 0.1"
  end

  def new_game_button(conn) do
    button("New game", to: Routes.hangman_path(conn, :create))
  end

  def game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end
end
