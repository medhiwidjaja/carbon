defmodule Carbon.Fetcher do
  require Logger

  @urlbase Application.get_env(:carbon, :urlbase)
  @table :carbon

  def start() do
    response = Mojito.request(:get, "#{@urlbase}/intensity")
    handle_response(response)
  end
  def start(from, to) do
    response = Mojito.request(:get, "#{@urlbase}/intensity/#{from}/#{to}")
    handle_response(response)
  end

  defp handle_response({:ok, %Mojito.Response{status_code: code, body: body}})
  when code >= 200 and code <= 304 do
    Logger.info "Fetcher completed"
    :ets.insert @table, {self(), body}
    {:ok, self()}
  end

  defp handle_response({:error, reason}) do
    Logger.info "Fetcher error due to #{inspect reason}"
   {:error, reason}
 end

 defp handle_response(_) do
    Logger.info "Fetcher errored out"
   {:error, :unknown}
 end

end
