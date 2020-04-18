defmodule GallowsWeb.Views.Helper.GameStateHelper do
  import Phoenix.HTML, only: [raw: 1]

  @responses %{
    :won => {:info, "You won!"},
    :lost => {:danger, "You lost!"},
    :good_guess => {:info, "Good guess!"},
    :bad_guess => {:warning, "Bad guess!"},
    :already_used => {:info, "You already guessed that..."}
  }

  def letters(letters) do
    letters |> Enum.join(" ")
  end

  def game_state(%{game_state: game_state}) do
    @responses[game_state]
    |> alert()
  end

  defp alert(nil), do: ""

  defp alert({class, message}) do
    """
    <div class="alert alert-#{class}">
    #{message}
    </div>
    """
    |> raw()
  end
end
