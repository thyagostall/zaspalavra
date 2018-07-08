defmodule ZaspalavraWeb.PageController do
  use ZaspalavraWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
