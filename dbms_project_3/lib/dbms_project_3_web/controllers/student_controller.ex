defmodule DbmsProject3Web.StudentController do
  use DbmsProject3Web, :controller

  alias DbmsProject3.Students
  alias DbmsProject3.Students.Student
  alias DbmsProject3.Groups
  alias DbmsProject3.EducationLevels

  def index(conn, params) do
    if(params !== %{}) do
      search_term = get_in(params, ["query_students"])

      cond do
        is_search_term_int(search_term) === true ->
          students = Students.search_students_by_fac_num(search_term)
          render(conn, "index.html", students: students)

        true ->
          students = Students.search_students(search_term)
          render(conn, "index.html", students: students)
      end
    else
      students = Students.list_students()
      render(conn, "index.html", students: students)
    end
  end

  defp is_search_term_int(value) do
    case Integer.parse(value) do
      {_, ""} -> true
      {_, _} -> false
      :error -> false
    end
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    groups = Groups.list_groups()
    levels = EducationLevels.list_levels()
    changeset = Students.change_student(%Student{})
    render(conn, "new.html", changeset: changeset, groups: groups, levels: levels)
  end

  def create(conn, %{"student" => student_params}) do
    case Students.create_student(student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: Routes.student_path(conn, :show, student))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Students.get_student_assoc!(id)
    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    groups = Groups.list_groups()
    levels = EducationLevels.list_levels()
    student = Students.get_student!(id)
    changeset = Students.change_student(student)

    render(conn, "edit.html",
      student: student,
      changeset: changeset,
      groups: groups,
      levels: levels
    )
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Students.get_student!(id)

    case Students.update_student(student, student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: Routes.student_path(conn, :show, student))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Students.get_student!(id)
    {:ok, _student} = Students.delete_student(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: Routes.student_path(conn, :index))
  end
end
