defmodule ZaspalavraWeb.PageController do
  use ZaspalavraWeb, :controller

  alias Zaspalavra.Words
  alias Zaspalavra.Dictionary

  def show(conn, %{"id" => id}) do
    word = Words.get_word!(id)
    show_word(conn, word)
  end

  def index(conn, _params) do
    random_id = Words.get_random_id()
    conn
    |> redirect(to: page_path(conn, :show, random_id))
  end

  def approve(conn, %{"id" => word_id}) do
    :ok = Words.approve(word_id)

    conn
    |> put_flash(:info, "Voto recebido")
    |> redirect to: "/"
  end

  def reject(conn, %{"id" => word_id}) do
    :ok = Words.reject(word_id)

    conn
    |> put_flash(:info, "Voto recebido")
    |> redirect to: "/"
  end

  defp show_word(conn, {:not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ZaspalavraWeb.ErrorView, "404.html")
  end

  defp show_word(conn, {:ok, word}) do
    definition_url = Dictionary.definition_url(word.word)
    render conn, "index.html", word: word, definition_url: definition_url
  end
end
