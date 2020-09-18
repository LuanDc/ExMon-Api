defmodule ExMon.Trainer.Pokemon.Get do
  alias ExMon.{Trainer.Pokemon, Repo}
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> handle_UUID()
  end

  defp handle_UUID({:ok, uuid}), do: get(uuid)

  defp handle_UUID(:error), do: {:error, "Invalid UI format!"}

  defp get(uuid) do
    uuid
    |> fetch_pokemon()
    |> handle_pokemon
  end

  defp handle_pokemon(nil),
    do: {:error, "Pokemon not found"}

  defp handle_pokemon(pokemon),
    do: {:ok, Repo.preload(pokemon, :trainer)}

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
