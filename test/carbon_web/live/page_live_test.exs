defmodule CarbonWeb.PageLiveTest do
  use CarbonWeb.ConnCase

  import Phoenix.LiveViewTest

  @create_attrs %{
    actual: 211,
    forecast: 209,
    from_time: ~U[2021-08-27 09:00:00Z],
    index: "moderate",
    to_time: ~U[2021-08-27 09:30:00Z]
  }

  defp fixture(:attr) do
    {:ok, attr} = Carbon.Measure.create_intensity(@create_attrs)
    attr
  end

  defp create_intensity(_) do
    attr = fixture(:attr)
    %{intensity: attr}
  end

  describe "LiveView" do
    setup [:create_intensity]

    test "shows current and forecast", %{conn: conn} do
      {:ok, page_live, _html} = live(conn, Routes.page_path(conn, :index))

      assert render(page_live) =~ "211"
      assert render(page_live) =~ "209"
      assert render(page_live) =~ "moderate"
    end

    test "disconnected and connected render", %{conn: conn} do
      {:ok, page_live, disconnected_html} = live(conn, "/")
      assert disconnected_html =~ "Carbon Intensity"
      assert render(page_live) =~ "Carbon Intensity"
    end
  end
end
