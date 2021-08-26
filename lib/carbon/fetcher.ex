defmodule Carbon.Fetcher do
  require Logger

  @table :carbon

  def start(base_url) do
    response = Mojito.request(:get, base_url)
    handle_response(response)
  end

  def start(base_url, from) do
    response = Mojito.request(:get, "#{base_url}/#{from}")
    handle_response(response)
  end

  def start(base_url, from, to) do
    response = Mojito.request(:get, "#{base_url}/#{from}/#{to}")
    handle_response(response)
  end

  defp handle_response({:ok, %Mojito.Response{status_code: code, body: body}})
  when code >= 200 and code <= 304 do
    Logger.info "Fetcher completed"
    :ets.insert @table, {self(), body}
    {:ok, self()}
  end

  defp handle_response({:error, error}) do
    reason = error.reason.reason
    Logger.info "Fetcher error due to #{inspect reason}"
   {:error, reason}
 end

 defp handle_response(_) do
    Logger.info "Fetcher errored out"
   {:error, :unknown}
 end

end
