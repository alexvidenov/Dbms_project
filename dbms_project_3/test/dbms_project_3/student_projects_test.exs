defmodule DbmsProject3.StudentProjectsTest do
  use DbmsProject3.DataCase

  alias DbmsProject3.StudentProjects

  describe "projects" do
    alias DbmsProject3.StudentProjects.Project

    @valid_attrs %{annual_production_program: 42, classifier: "some classifier", notes: "some notes", project_defending_date: ~D[2010-04-17], task_given_date: ~D[2010-04-17], topic: "some topic"}
    @update_attrs %{annual_production_program: 43, classifier: "some updated classifier", notes: "some updated notes", project_defending_date: ~D[2011-05-18], task_given_date: ~D[2011-05-18], topic: "some updated topic"}
    @invalid_attrs %{annual_production_program: nil, classifier: nil, notes: nil, project_defending_date: nil, task_given_date: nil, topic: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StudentProjects.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert StudentProjects.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert StudentProjects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = StudentProjects.create_project(@valid_attrs)
      assert project.annual_production_program == 42
      assert project.classifier == "some classifier"
      assert project.notes == "some notes"
      assert project.project_defending_date == ~D[2010-04-17]
      assert project.task_given_date == ~D[2010-04-17]
      assert project.topic == "some topic"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StudentProjects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = StudentProjects.update_project(project, @update_attrs)
      assert project.annual_production_program == 43
      assert project.classifier == "some updated classifier"
      assert project.notes == "some updated notes"
      assert project.project_defending_date == ~D[2011-05-18]
      assert project.task_given_date == ~D[2011-05-18]
      assert project.topic == "some updated topic"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = StudentProjects.update_project(project, @invalid_attrs)
      assert project == StudentProjects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = StudentProjects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> StudentProjects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = StudentProjects.change_project(project)
    end
  end
end
