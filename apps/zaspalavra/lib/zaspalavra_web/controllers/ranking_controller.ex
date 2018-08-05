defmodule ZaspalavraWeb.RankingController do
  use ZaspalavraWeb, :controller

  alias Zaspalavra.Ranking

  def index(conn, _) do
    words = Ranking.take_best(10)
    render conn, "index.html", words: words
  end
end
