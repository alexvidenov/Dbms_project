defmodule DbmsProject3.Students do
  import Ecto.Query, warn: false

  alias DbmsProject3.Repo
  alias DbmsProject3.Students.Student

  def list_students do
    Student |> Repo.all()
  end

  def get_student!(id), do: Repo.get!(Student, id)

  # Was failing due to preloaded project not preloading its marks
  def get_student_assoc!(id),
    do:
      Student
      |> where([student], student.id == ^id)
      |> join(:left, [s], _ in assoc(s, :project))
      |> join(:left, [_, project], _ in assoc(project, :marks))
      |> preload([_, p, m], project: {p, marks: m})
      |> Repo.one()

  # Repo.get!(id) |> Repo.preload(:project)

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
