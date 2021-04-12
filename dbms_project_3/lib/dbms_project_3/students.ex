defmodule DbmsProject3.Students do
  import Ecto.Query, warn: false

  alias DbmsProject3.Repo
  alias DbmsProject3.Students.Student

  def list_students do
    Student |> Repo.all()
  end

  def search_students(params) do
    search_term = get_in(params, ["query_students"])

    Student
    |> Student.search(search_term)
    |> Repo.all()
  end

  def search_students_by_fac_num(params) do
    search_term = get_in(params, ["query_students"])

    Student
    |> Student.with_fac_num(search_term)
    |> Repo.all()
  end

  def get_student!(id), do: Repo.get!(Student, id)

  def get_student_assoc!(id) do
    Student
    |> where([student], student.id == ^id)
    |> join(:left, [s, _], _ in assoc(s, :project))
    |> join(:left, [_, project], _ in assoc(project, :marks))
    |> preload([_, p, m], project: {p, marks: m})
    |> Repo.one()
    |> Repo.preload(:group)
    |> Repo.preload(:level)
  end

  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end
end
