defmodule DbmsProject3.EducationLevelsTest do
  use DbmsProject3.DataCase

  alias DbmsProject3.EducationLevels

  describe "levels" do
    alias DbmsProject3.EducationLevels.Level

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def level_fixture(attrs \\ %{}) do
      {:ok, level} =
        attrs
        |> Enum.into(@valid_attrs)
        |> EducationLevels.create_level()

      level
    end

    test "list_levels/0 returns all levels" do
      level = level_fixture()
      assert EducationLevels.list_levels() == [level]
    end

    test "get_level!/1 returns the level with given id" do
      level = level_fixture()
      assert EducationLevels.get_level!(level.id) == level
    end

    test "create_level/1 with valid data creates a level" do
      assert {:ok, %Level{} = level} = EducationLevels.create_level(@valid_attrs)
      assert level.name == "some name"
    end

    test "create_level/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EducationLevels.create_level(@invalid_attrs)
    end

    test "update_level/2 with valid data updates the level" do
      level = level_fixture()
      assert {:ok, %Level{} = level} = EducationLevels.update_level(level, @update_attrs)
      assert level.name == "some updated name"
    end

    test "update_level/2 with invalid data returns error changeset" do
      level = level_fixture()
      assert {:error, %Ecto.Changeset{}} = EducationLevels.update_level(level, @invalid_attrs)
      assert level == EducationLevels.get_level!(level.id)
    end

    test "delete_level/1 deletes the level" do
      level = level_fixture()
      assert {:ok, %Level{}} = EducationLevels.delete_level(level)
      assert_raise Ecto.NoResultsError, fn -> EducationLevels.get_level!(level.id) end
    end

    test "change_level/1 returns a level changeset" do
      level = level_fixture()
      assert %Ecto.Changeset{} = EducationLevels.change_level(level)
    end
  end
end
