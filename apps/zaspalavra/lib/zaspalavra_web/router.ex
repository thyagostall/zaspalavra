defmodule ZaspalavraWeb.Router do
  use ZaspalavraWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ZaspalavraWeb do
    pipe_through :browser # Use the default browser stack

    get "/poll/:id", PageController, :show
    get "/", PageController, :index

    post "/approve/:id", PageController, :approve
    post "/reject/:id", PageController, :reject

    resources "/words", WordController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ZaspalavraWeb do
  #   pipe_through :api
  # end
end
