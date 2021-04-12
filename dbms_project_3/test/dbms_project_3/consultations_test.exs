defmodule DbmsProject3.ConsultationsTest do
  use DbmsProject3.DataCase

  alias DbmsProject3.Consultations

  describe "consultations" do
    alias DbmsProject3.Consultations.Consultation

    @valid_attrs %{consultation_date: ~D[2010-04-17]}
    @update_attrs %{consultation_date: ~D[2011-05-18]}
    @invalid_attrs %{consultation_date: nil}

    def consultation_fixture(attrs \\ %{}) do
      {:ok, consultation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Consultations.create_consultation()

      consultation
    end

    test "list_consultations/0 returns all consultations" do
      consultation = consultation_fixture()
      assert Consultations.list_consultations() == [consultation]
    end

    test "get_consultation!/1 returns the consultation with given id" do
      consultation = consultation_fixture()
      assert Consultations.get_consultation!(consultation.id) == consultation
    end

    test "create_consultation/1 with valid data creates a consultation" do
      assert {:ok, %Consultation{} = consultation} = Consultations.create_consultation(@valid_attrs)
      assert consultation.consultation_date == ~D[2010-04-17]
    end

    test "create_consultation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Consultations.create_consultation(@invalid_attrs)
    end

    test "update_consultation/2 with valid data updates the consultation" do
      consultation = consultation_fixture()
      assert {:ok, %Consultation{} = consultation} = Consultations.update_consultation(consultation, @update_attrs)
      assert consultation.consultation_date == ~D[2011-05-18]
    end

    test "update_consultation/2 with invalid data returns error changeset" do
      consultation = consultation_fixture()
      assert {:error, %Ecto.Changeset{}} = Consultations.update_consultation(consultation, @invalid_attrs)
      assert consultation == Consultations.get_consultation!(consultation.id)
    end

    test "delete_consultation/1 deletes the consultation" do
      consultation = consultation_fixture()
      assert {:ok, %Consultation{}} = Consultations.delete_consultation(consultation)
      assert_raise Ecto.NoResultsError, fn -> Consultations.get_consultation!(consultation.id) end
    end

    test "change_consultation/1 returns a consultation changeset" do
      consultation = consultation_fixture()
      assert %Ecto.Changeset{} = Consultations.change_consultation(consultation)
    end
  end
end
