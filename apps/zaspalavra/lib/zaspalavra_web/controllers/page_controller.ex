defmodule ZaspalavraWeb.PageController do
  use ZaspalavraWeb, :controller

  alias Zaspalavra.Words

  def show(conn, %{"id" => id}) do
    word = Words.get_word!(id)
    render conn, "index.html", word: word
  end

  def index(conn, _params) do
    random_id = Words.get_random_id()
    conn
    |> redirect(to: page_path(conn, :show, random_id))
  end
end
