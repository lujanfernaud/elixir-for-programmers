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
    letters: []
  )

  def new_game do
    %Hangman.Game{
      letters: Dictionary.random_word() |> String.codepoints()
    }
  end
end
