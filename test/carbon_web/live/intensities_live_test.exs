defmodule CarbonWeb.IntensityLiveTest do
  use CarbonWeb.ConnCase
  import Ecto.Query, warn: false

  import Phoenix.LiveViewTest

  defp create_intensity() do
    1..30
    |> Enum.each(fn i ->
      {:ok, attr} =
        Carbon.Measure.create_intensity(%{
          actual: 111,
          forecast: 112,
          from_time: DateTime.new!(Date.new!(1990, 8, i), Time.new!(0, 0, 0), "Etc/UTC"),
          index: "low",
          to_time: DateTime.new!(Date.new!(1990, 8, i), Time.new!(0, 0, 0), "Etc/UTC")
        })
    end)
  end

  setup_all do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Carbon.Repo)
  end

  setup do
    create_intensity()
  end

  test "ensure database is not empty" do
    assert Carbon.Repo.aggregate(from(e in "intensities"), :count, :id) == 30
  end

  test "shows table", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, Routes.intensity_index_path(conn, :index))

    assert render(page_live) =~ "111"
    assert render(page_live) =~ "112"
    assert render(page_live) =~ "low"
  end

  test "click next page", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.intensity_index_path(conn, :index))

    assert view |> has_element?("a", "2")

    view
    |> element("a", "2")
    |> render_click()
    |> follow_redirect(conn)

    assert_redirected(view, "/table?page=2")
  end
end
