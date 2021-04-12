defmodule DbmsProject3Web.ProjectController do
  use DbmsProject3Web, :controller

  require Logger

  alias DbmsProject3.StudentProjects
  alias DbmsProject3.StudentProjects.Project

  alias DbmsProject3.Students

  def index(conn, _params) do
    projects = StudentProjects.list_projects()
    render(conn, "index.html", projects: projects)
  end

  def new(conn, %{"student_id" => id}) do
    student = Students.get_student!(id)
    changeset = StudentProjects.change_project(%Project{})
    render(conn, "new.html", changeset: changeset, student: student)
  end

  def create(conn, %{"project" => project_params}) do
    case StudentProjects.create_project(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    project = StudentProjects.get_project_assoc!(id)
    Logger.debug("PROJECT: #{inspect(project)}")
    render(conn, "show.html", project: project)
  end

  def edit(conn, %{"id" => id}) do
    project = StudentProjects.get_project_assoc!(id)
    changeset = StudentProjects.change_project(project)
    render(conn, "edit.html", project: project, student: project.student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = StudentProjects.get_project!(id)

    case StudentProjects.update_project(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = StudentProjects.get_project!(id)
    {:ok, _project} = StudentProjects.delete_project(project)

    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :index))
  end
end
