defmodule ExMon.Trainer.Delete do
  alias ExMon.{Trainer, Repo}
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
    |> fetch_trainer()
    |> handle_trainer
  end

  defp handle_trainer(nil),
    do: {:error, "Trainer not found"}

  defp handle_trainer(trainer) do
    Repo.delete(trainer)
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
