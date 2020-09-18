defmodule ExMonWeb.FallbackController do
  use ExMonWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ExMonWeb.ErrorView)
    |> render("401.json", result: "trainer unauthorized")
  end

  def call(conn, {:error, %{message: reason, status: 404}}) do
    conn
    |> put_status(404)
    |> put_view(ExMonWeb.ErrorView)
    |> render("404.json", result: reason)
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExMonWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
