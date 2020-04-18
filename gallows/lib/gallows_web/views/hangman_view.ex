defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.Views.Helper.GameStateHelper

  def new_game_button(conn) do
    button "New game", to: Routes.hangman_path(conn, :create)
  end

  def game_over?(%{ game_state: game_state }) do
    game_state in [ :won, :lost ]
  end
end
