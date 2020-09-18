defmodule ExMon.Trainer.Pokemon.Delete do
  alias ExMon.{Trainer.Pokemon, Repo}
  alias Ecto.UUID

  def call(id) do
    id
    |> UUID.cast()
    |> handle_UUID
  end

  defp handle_UUID({:ok, uuid}), do: delete(uuid)

  defp handle_UUID(:error), do: {:error, "Invalid UI format!"}

  defp delete(uuid) do
    uuid
    |> fetch_pokemon()
    |> handle_pokemon
  end

  defp handle_pokemon(nil),
    do: {:error, "Pokemon not found"}

  defp handle_pokemon(pokemon) do
    Repo.delete(pokemon)
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
