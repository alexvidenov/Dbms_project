defmodule DbmsProject3.StudentProjects do
  @moduledoc """
  The StudentProjects context.
  """

  import Ecto.Query, warn: false
  alias DbmsProject3.Repo

  alias DbmsProject3.StudentProjects.Project

  def list_projects, do: Project |> Repo.all()

  def search_projects(params),
    do: Project |> Project.search(params) |> Repo.all()

  def project_count_for_year(params), do: Project |> Project.count_by_seach(params) |> Repo.one()

  def get_project!(id), do: Project |> Repo.get!(id)

  def get_project_assoc!(id),
    do:
      Project
      |> Repo.get!(id)
      |> Repo.preload(:student)
      |> Repo.preload(:marks)
      |> Repo.preload(:consultations)

  def create_project(attrs \\ %{}),
    do:
      %Project{}
      |> Project.changeset(attrs)
      |> Repo.insert()

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
