defmodule DbmsProject3Web.MarkController do
  use DbmsProject3Web, :controller

  alias DbmsProject3.ProjectMarks
  alias DbmsProject3.ProjectMarks.Mark
  alias DbmsProject3.StudentProjects

  def index(conn, _params) do
    marks = ProjectMarks.list_marks()
    render(conn, "index.html", marks: marks)
  end

  def new(conn, %{"project_id" => id}) do
    project = StudentProjects.get_project!(id)
    changeset = ProjectMarks.change_mark(%Mark{})
    render(conn, "new.html", changeset: changeset, project: project)
  end

  def create(conn, %{"mark" => mark_params}) do
    average = get_average_from_mark_params(mark_params)

    case ProjectMarks.create_mark(mark_params, average) do
      {:ok, mark} ->
        conn
        |> put_flash(:info, "Mark created successfully.")
        |> redirect(to: Routes.mark_path(conn, :show, mark))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mark = ProjectMarks.get_mark!(id)
    render(conn, "show.html", mark: mark)
  end

  def edit(conn, %{"id" => id}) do
    mark = ProjectMarks.get_mark_assoc!(id)
    changeset = ProjectMarks.change_mark(mark)
    render(conn, "edit.html", mark: mark, project: mark.project, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mark" => mark_params}) do
    mark = ProjectMarks.get_mark!(id)

    average = get_average_from_mark_params(mark_params)

    mark_params_with_calculated_avg = Map.put(mark_params, "total_mark", average)

    case ProjectMarks.update_mark(mark, mark_params_with_calculated_avg) do
      {:ok, mark} ->
        conn
        |> put_flash(:info, "Mark updated successfully.")
        |> redirect(to: Routes.mark_path(conn, :show, mark))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", mark: mark, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mark = ProjectMarks.get_mark!(id)
    {:ok, _mark} = ProjectMarks.delete_mark(mark)

    conn
    |> put_flash(:info, "Mark deleted successfully.")
    |> redirect(to: Routes.mark_path(conn, :index))
  end

  defp get_average_from_mark_params(mark_params),
    do:
      (String.to_integer(mark_params["mark_1"]) + String.to_integer(mark_params["mark_2"]) +
         String.to_integer(mark_params["mark_3"]) + String.to_integer(mark_params["mark_4"]) +
         String.to_integer(mark_params["mark_5"])) / 5
end
