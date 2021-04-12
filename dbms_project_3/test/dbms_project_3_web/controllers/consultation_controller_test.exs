defmodule DbmsProject3Web.ConsultationControllerTest do
  use DbmsProject3Web.ConnCase

  alias DbmsProject3.Consultations

  @create_attrs %{consultation_date: ~D[2010-04-17]}
  @update_attrs %{consultation_date: ~D[2011-05-18]}
  @invalid_attrs %{consultation_date: nil}

  def fixture(:consultation) do
    {:ok, consultation} = Consultations.create_consultation(@create_attrs)
    consultation
  end

  describe "index" do
    test "lists all consultations", %{conn: conn} do
      conn = get(conn, Routes.consultation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Consultations"
    end
  end

  describe "new consultation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.consultation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Consultation"
    end
  end

  describe "create consultation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.consultation_path(conn, :create), consultation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.consultation_path(conn, :show, id)

      conn = get(conn, Routes.consultation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Consultation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.consultation_path(conn, :create), consultation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Consultation"
    end
  end

  describe "edit consultation" do
    setup [:create_consultation]

    test "renders form for editing chosen consultation", %{conn: conn, consultation: consultation} do
      conn = get(conn, Routes.consultation_path(conn, :edit, consultation))
      assert html_response(conn, 200) =~ "Edit Consultation"
    end
  end

  describe "update consultation" do
    setup [:create_consultation]

    test "redirects when data is valid", %{conn: conn, consultation: consultation} do
      conn = put(conn, Routes.consultation_path(conn, :update, consultation), consultation: @update_attrs)
      assert redirected_to(conn) == Routes.consultation_path(conn, :show, consultation)

      conn = get(conn, Routes.consultation_path(conn, :show, consultation))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, consultation: consultation} do
      conn = put(conn, Routes.consultation_path(conn, :update, consultation), consultation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Consultation"
    end
  end

  describe "delete consultation" do
    setup [:create_consultation]

    test "deletes chosen consultation", %{conn: conn, consultation: consultation} do
      conn = delete(conn, Routes.consultation_path(conn, :delete, consultation))
      assert redirected_to(conn) == Routes.consultation_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.consultation_path(conn, :show, consultation))
      end
    end
  end

  defp create_consultation(_) do
    consultation = fixture(:consultation)
    %{consultation: consultation}
  end
end
