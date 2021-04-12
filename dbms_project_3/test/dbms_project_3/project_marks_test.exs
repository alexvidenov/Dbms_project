defmodule DbmsProject3.ProjectMarksTest do
  use DbmsProject3.DataCase

  alias DbmsProject3.ProjectMarks

  describe "marks" do
    alias DbmsProject3.ProjectMarks.Mark

    @valid_attrs %{final_mark: 42, mark_1: 42, mark_2: 42, mark_3: 42, mark_4: 42, mark_5: 42, total_mark: 120.5}
    @update_attrs %{final_mark: 43, mark_1: 43, mark_2: 43, mark_3: 43, mark_4: 43, mark_5: 43, total_mark: 456.7}
    @invalid_attrs %{final_mark: nil, mark_1: nil, mark_2: nil, mark_3: nil, mark_4: nil, mark_5: nil, total_mark: nil}

    def mark_fixture(attrs \\ %{}) do
      {:ok, mark} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProjectMarks.create_mark()

      mark
    end

    test "list_marks/0 returns all marks" do
      mark = mark_fixture()
      assert ProjectMarks.list_marks() == [mark]
    end

    test "get_mark!/1 returns the mark with given id" do
      mark = mark_fixture()
      assert ProjectMarks.get_mark!(mark.id) == mark
    end

    test "create_mark/1 with valid data creates a mark" do
      assert {:ok, %Mark{} = mark} = ProjectMarks.create_mark(@valid_attrs)
      assert mark.final_mark == 42
      assert mark.mark_1 == 42
      assert mark.mark_2 == 42
      assert mark.mark_3 == 42
      assert mark.mark_4 == 42
      assert mark.mark_5 == 42
      assert mark.total_mark == 120.5
    end

    test "create_mark/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProjectMarks.create_mark(@invalid_attrs)
    end

    test "update_mark/2 with valid data updates the mark" do
      mark = mark_fixture()
      assert {:ok, %Mark{} = mark} = ProjectMarks.update_mark(mark, @update_attrs)
      assert mark.final_mark == 43
      assert mark.mark_1 == 43
      assert mark.mark_2 == 43
      assert mark.mark_3 == 43
      assert mark.mark_4 == 43
      assert mark.mark_5 == 43
      assert mark.total_mark == 456.7
    end

    test "update_mark/2 with invalid data returns error changeset" do
      mark = mark_fixture()
      assert {:error, %Ecto.Changeset{}} = ProjectMarks.update_mark(mark, @invalid_attrs)
      assert mark == ProjectMarks.get_mark!(mark.id)
    end

    test "delete_mark/1 deletes the mark" do
      mark = mark_fixture()
      assert {:ok, %Mark{}} = ProjectMarks.delete_mark(mark)
      assert_raise Ecto.NoResultsError, fn -> ProjectMarks.get_mark!(mark.id) end
    end

    test "change_mark/1 returns a mark changeset" do
      mark = mark_fixture()
      assert %Ecto.Changeset{} = ProjectMarks.change_mark(mark)
    end
  end
end
