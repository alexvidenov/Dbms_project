defmodule DbmsProject3Web.StudentControllerTest do
  use DbmsProject3Web.ConnCase

  alias DbmsProject3.Students

  @create_attrs %{certified_semester: 42, fac_number: 42, first_name: "some first_name", form_of_education: "some form_of_education", last_name: "some last_name", middle_name: "some middle_name", studying_year: "some studying_year"}
  @update_attrs %{certified_semester: 43, fac_number: 43, first_name: "some updated first_name", form_of_education: "some updated form_of_education", last_name: "some updated last_name", middle_name: "some updated middle_name", studying_year: "some updated studying_year"}
  @invalid_attrs %{certified_semester: nil, fac_number: nil, first_name: nil, form_of_education: nil, last_name: nil, middle_name: nil, studying_year: nil}

  def fixture(:student) do
    {:ok, student} = Students.create_student(@create_attrs)
    student
  end

  describe "index" do
    test "lists all students", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Students"
    end
  end

  describe "new student" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :new))
      assert html_response(conn, 200) =~ "New Student"
    end
  end

  describe "create student" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.student_path(conn, :show, id)

      conn = get(conn, Routes.student_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Student"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Student"
    end
  end

  describe "edit student" do
    setup [:create_student]

    test "renders form for editing chosen student", %{conn: conn, student: student} do
      conn = get(conn, Routes.student_path(conn, :edit, student))
      assert html_response(conn, 200) =~ "Edit Student"
    end
  end

  describe "update student" do
    setup [:create_student]

    test "redirects when data is valid", %{conn: conn, student: student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @update_attrs)
      assert redirected_to(conn) == Routes.student_path(conn, :show, student)

      conn = get(conn, Routes.student_path(conn, :show, student))
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, student: student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Student"
    end
  end

  describe "delete student" do
    setup [:create_student]

    test "deletes chosen student", %{conn: conn, student: student} do
      conn = delete(conn, Routes.student_path(conn, :delete, student))
      assert redirected_to(conn) == Routes.student_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.student_path(conn, :show, student))
      end
    end
  end

  defp create_student(_) do
    student = fixture(:student)
    %{student: student}
  end
end
