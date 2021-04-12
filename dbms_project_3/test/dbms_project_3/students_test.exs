defmodule DbmsProject3.StudentsTest do
  use DbmsProject3.DataCase

  alias DbmsProject3.Students

  describe "students" do
    alias DbmsProject3.Students.Student

    @valid_attrs %{certified_semester: 42, fac_number: 42, first_name: "some first_name", form_of_education: "some form_of_education", last_name: "some last_name", middle_name: "some middle_name", studying_year: "some studying_year"}
    @update_attrs %{certified_semester: 43, fac_number: 43, first_name: "some updated first_name", form_of_education: "some updated form_of_education", last_name: "some updated last_name", middle_name: "some updated middle_name", studying_year: "some updated studying_year"}
    @invalid_attrs %{certified_semester: nil, fac_number: nil, first_name: nil, form_of_education: nil, last_name: nil, middle_name: nil, studying_year: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Students.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Students.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Students.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Students.create_student(@valid_attrs)
      assert student.certified_semester == 42
      assert student.fac_number == 42
      assert student.first_name == "some first_name"
      assert student.form_of_education == "some form_of_education"
      assert student.last_name == "some last_name"
      assert student.middle_name == "some middle_name"
      assert student.studying_year == "some studying_year"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = Students.update_student(student, @update_attrs)
      assert student.certified_semester == 43
      assert student.fac_number == 43
      assert student.first_name == "some updated first_name"
      assert student.form_of_education == "some updated form_of_education"
      assert student.last_name == "some updated last_name"
      assert student.middle_name == "some updated middle_name"
      assert student.studying_year == "some updated studying_year"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student == Students.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Students.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Students.change_student(student)
    end
  end
end
