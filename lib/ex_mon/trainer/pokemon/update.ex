defmodule ExMon.Trainer.Pokemon.Update do
  alias ExMon.{Trainer.Pokemon, Repo}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    uuid
    |> UUID.cast()
    |> handle_UUID(params)
  end

  defp handle_UUID({:ok, _uuid}, params), do: update(params)

  defp handle_UUID(:error, _params), do: {:error, "Invalid UI format!"}

  defp update(%{"id" => uuid} = params) do
    uuid
    |> fetch_pokemon()
    |> handle_pokemon(params)
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)

  defp handle_pokemon(nil, _pokemon),
    do: {:error, "Pokemon not found"}

  defp handle_pokemon(pokemon, params) do
    pokemon
    |> Pokemon.update_changeset(params)
    |> Repo.update()
  end
end
