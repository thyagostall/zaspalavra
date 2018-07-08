defmodule Zaspalavra.WordsTest do
  use Zaspalavra.DataCase

  alias Zaspalavra.Words

  describe "words" do
    alias Zaspalavra.Words.Word

    @valid_attrs %{prefix: "some prefix", votes: 42, word: "some word"}
    @update_attrs %{prefix: "some updated prefix", votes: 43, word: "some updated word"}
    @invalid_attrs %{prefix: nil, votes: nil, word: nil}

    def word_fixture(attrs \\ %{}) do
      {:ok, word} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Words.create_word()

      word
    end

    test "list_words/0 returns all words" do
      word = word_fixture()
      assert Words.list_words() == [word]
    end

    test "get_word!/1 returns the word with given id" do
      word = word_fixture()
      assert Words.get_word!(word.id) == word
    end

    test "create_word/1 with valid data creates a word" do
      assert {:ok, %Word{} = word} = Words.create_word(@valid_attrs)
      assert word.prefix == "some prefix"
      assert word.votes == 42
      assert word.word == "some word"
    end

    test "create_word/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Words.create_word(@invalid_attrs)
    end

    test "update_word/2 with valid data updates the word" do
      word = word_fixture()
      assert {:ok, word} = Words.update_word(word, @update_attrs)
      assert %Word{} = word
      assert word.prefix == "some updated prefix"
      assert word.votes == 43
      assert word.word == "some updated word"
    end

    test "update_word/2 with invalid data returns error changeset" do
      word = word_fixture()
      assert {:error, %Ecto.Changeset{}} = Words.update_word(word, @invalid_attrs)
      assert word == Words.get_word!(word.id)
    end

    test "delete_word/1 deletes the word" do
      word = word_fixture()
      assert {:ok, %Word{}} = Words.delete_word(word)
      assert_raise Ecto.NoResultsError, fn -> Words.get_word!(word.id) end
    end

    test "change_word/1 returns a word changeset" do
      word = word_fixture()
      assert %Ecto.Changeset{} = Words.change_word(word)
    end
  end
end
