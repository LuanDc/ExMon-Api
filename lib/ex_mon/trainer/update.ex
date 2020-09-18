defmodule ExMon.Trainer.Update do
  alias ExMon.{Trainer, Repo}
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
    |> fetch_trainer()
    |> handle_trainer(params)
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)

  defp handle_trainer(nil, _trainer),
    do: {:error, "Trainer not found"}

  defp handle_trainer(trainer, params) do
    params
    |> Trainer.changeset(trainer)
    |> Repo.update()
  end
end
