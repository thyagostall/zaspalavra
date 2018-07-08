defmodule ZaspalavraWeb.WordControllerTest do
  use ZaspalavraWeb.ConnCase

  alias Zaspalavra.Words

  @create_attrs %{prefix: "some prefix", votes: 42, word: "some word"}
  @update_attrs %{prefix: "some updated prefix", votes: 43, word: "some updated word"}
  @invalid_attrs %{prefix: nil, votes: nil, word: nil}

  def fixture(:word) do
    {:ok, word} = Words.create_word(@create_attrs)
    word
  end

  describe "index" do
    test "lists all words", %{conn: conn} do
      conn = get conn, word_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Words"
    end
  end

  describe "new word" do
    test "renders form", %{conn: conn} do
      conn = get conn, word_path(conn, :new)
      assert html_response(conn, 200) =~ "New Word"
    end
  end

  describe "create word" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, word_path(conn, :create), word: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == word_path(conn, :show, id)

      conn = get conn, word_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Word"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, word_path(conn, :create), word: @invalid_attrs
      assert html_response(conn, 200) =~ "New Word"
    end
  end

  describe "edit word" do
    setup [:create_word]

    test "renders form for editing chosen word", %{conn: conn, word: word} do
      conn = get conn, word_path(conn, :edit, word)
      assert html_response(conn, 200) =~ "Edit Word"
    end
  end

  describe "update word" do
    setup [:create_word]

    test "redirects when data is valid", %{conn: conn, word: word} do
      conn = put conn, word_path(conn, :update, word), word: @update_attrs
      assert redirected_to(conn) == word_path(conn, :show, word)

      conn = get conn, word_path(conn, :show, word)
      assert html_response(conn, 200) =~ "some updated prefix"
    end

    test "renders errors when data is invalid", %{conn: conn, word: word} do
      conn = put conn, word_path(conn, :update, word), word: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Word"
    end
  end

  describe "delete word" do
    setup [:create_word]

    test "deletes chosen word", %{conn: conn, word: word} do
      conn = delete conn, word_path(conn, :delete, word)
      assert redirected_to(conn) == word_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, word_path(conn, :show, word)
      end
    end
  end

  defp create_word(_) do
    word = fixture(:word)
    {:ok, word: word}
  end
end
