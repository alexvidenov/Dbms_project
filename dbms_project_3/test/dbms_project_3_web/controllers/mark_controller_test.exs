defmodule DbmsProject3Web.MarkControllerTest do
  use DbmsProject3Web.ConnCase

  alias DbmsProject3.ProjectMarks

  @create_attrs %{final_mark: 42, mark_1: 42, mark_2: 42, mark_3: 42, mark_4: 42, mark_5: 42, total_mark: 120.5}
  @update_attrs %{final_mark: 43, mark_1: 43, mark_2: 43, mark_3: 43, mark_4: 43, mark_5: 43, total_mark: 456.7}
  @invalid_attrs %{final_mark: nil, mark_1: nil, mark_2: nil, mark_3: nil, mark_4: nil, mark_5: nil, total_mark: nil}

  def fixture(:mark) do
    {:ok, mark} = ProjectMarks.create_mark(@create_attrs)
    mark
  end

  describe "index" do
    test "lists all marks", %{conn: conn} do
      conn = get(conn, Routes.mark_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Marks"
    end
  end

  describe "new mark" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.mark_path(conn, :new))
      assert html_response(conn, 200) =~ "New Mark"
    end
  end

  describe "create mark" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.mark_path(conn, :create), mark: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.mark_path(conn, :show, id)

      conn = get(conn, Routes.mark_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Mark"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.mark_path(conn, :create), mark: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Mark"
    end
  end

  describe "edit mark" do
    setup [:create_mark]

    test "renders form for editing chosen mark", %{conn: conn, mark: mark} do
      conn = get(conn, Routes.mark_path(conn, :edit, mark))
      assert html_response(conn, 200) =~ "Edit Mark"
    end
  end

  describe "update mark" do
    setup [:create_mark]

    test "redirects when data is valid", %{conn: conn, mark: mark} do
      conn = put(conn, Routes.mark_path(conn, :update, mark), mark: @update_attrs)
      assert redirected_to(conn) == Routes.mark_path(conn, :show, mark)

      conn = get(conn, Routes.mark_path(conn, :show, mark))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, mark: mark} do
      conn = put(conn, Routes.mark_path(conn, :update, mark), mark: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Mark"
    end
  end

  describe "delete mark" do
    setup [:create_mark]

    test "deletes chosen mark", %{conn: conn, mark: mark} do
      conn = delete(conn, Routes.mark_path(conn, :delete, mark))
      assert redirected_to(conn) == Routes.mark_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.mark_path(conn, :show, mark))
      end
    end
  end

  defp create_mark(_) do
    mark = fixture(:mark)
    %{mark: mark}
  end
end
