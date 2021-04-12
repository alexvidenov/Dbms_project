defmodule DbmsProject3.StudentProjects do
  @moduledoc """
  The StudentProjects context.
  """

  import Ecto.Query, warn: false
  alias DbmsProject3.Repo

  alias DbmsProject3.StudentProjects.Project

  def list_projects do
    Project |> Repo.all()
  end

  def search_projects(params) do
    search_term = get_in(params, ["query_projects"])

    Project |> Project.search(search_term) |> Repo.all()
  end

  def get_project!(id), do: Project |> Repo.get!(id)

  def get_project_assoc!(id),
    do: Project |> Repo.get!(id) |> Repo.preload(:student) |> Repo.preload(:marks)

  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end
end
