defmodule DbmsProject3Web.StudentController do
  use DbmsProject3Web, :controller

  alias DbmsProject3.Students
  alias DbmsProject3.Students.Student
  alias DbmsProject3.Groups
  alias DbmsProject3.EducationLevels

  def index(conn, params) do
    cond do
      is_integer(params) == true ->
        students = Students.search_students_by_fac_num(params)
        render(conn, "index.html", students: students)

      true ->
        students = Students.search_students(params)
        render(conn, "index.html", students: students)
    end
  end

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
    # Doesnt load the STUDENT ASSOC OF PROJECT HERE
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
