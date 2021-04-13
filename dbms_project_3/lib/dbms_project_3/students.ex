defmodule DbmsProject3.Students do
  import Ecto.Query, warn: false

  alias DbmsProject3.Repo
  alias DbmsProject3.Students.Student

  require Logger

  def list_students do
    Student |> Repo.all()
  end

  def search_students(params) do
    Student
    |> Student.search(params)
    |> Repo.all()
  end

  def search_students_by_fac_num(params) do
    Logger.debug("EBASI: #{inspect(params)}")

    Student
    |> Student.with_fac_num(params)
    |> Repo.all()
  end

  def get_student!(id), do: Repo.get!(Student, id)

  def get_student_assoc!(id) do
    Student
    |> where([s], s.id == ^id)
    |> join(:left, [s, _], _ in assoc(s, :project))
    |> join(:left, [_, p], _ in assoc(p, :consultations))
    |> join(:left, [_, p], _ in assoc(p, :marks))
    |> preload([_, p, c, m], project: {p, marks: m, consultations: c})
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
