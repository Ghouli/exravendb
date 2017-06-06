defmodule ExRavenDB.Client do

  def server do
    server = Application.get_env(:exravendb, :server)
    port = Application.get_env(:exravendb, :port)
    "#{server}:#{port}"
  end

  # Document commands
  def put(database, header \\ [], data \\ "") do
    url = "#{server}/databases/#{database}/docs"
    HTTPoison.post!(url, data, header)
  end

  def put(database, key, header \\ [], data \\ "") do
    url = "#{server}/databases/#{database}/docs/#{key}"
    HTTPoison.put!(url, data, header)
  end

  def get(database, key, header \\ []) do
    url = "#{server}/databases/#{database}/docs/#{key}"
    HTTPoison.get!(url, header)
  end

  def get(database, key, header \\ [], include \\ "", transformer_param \\ "", transformer_param_value \\ "", metadata \\ "") do
    url = "#{server}/databases/#{database}/queries/?metadata-only=#{metadata}&include=#{include}&tp#{transformer_param}=#{transformer_param_value}&id=#{key}"
    HTTPoison.get!(url, header)
  end

  def get(database, key, header \\ [], include \\ "", transformer \\ "", transformer_param \\ "", transformer_param_value \\ "", metadata \\ "") do
    url = "#{server}/databases/#{database}/queries/?metadata-only=#{metadata}&include=#{include}&transformer=#{transformer}&tp#{transformer_param}=#{transformer_param_value}&id=#{key}"
    HTTPoison.get!(url, header)
  end

end