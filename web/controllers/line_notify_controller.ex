defmodule Poselink.LineNotifyController do
  use Poselink.Web, :controller

  alias Poselink.Service
  alias Poselink.UserServiceConfig

  @token_url "https://notify-bot.line.me/oauth/token"
  @grant_type "authorization_code"
  @redirect_uri "https://t21.bearlab.io/redirect/line_notify/callback"
  @client_id "p2NJpZH0R3d9HJFVfpuyAq"
  @client_secret "H4rpTU5PfQysPDIHjCZQ1Y8jG9FkhI8JkXlfYYo8Gip"

  @headers ["Content-Type": "application/x-www-form-urlencoded"]

  @options [ ssl: [{:versions, [:'tlsv1.2']}] ]

  def callback(conn, %{"code" => code, "state" => token}) do
    case Guardian.serializer.from_access_token(token) do
      {:ok, user} ->
        IO.puts "user: #{user.username} code: #{code}"
        case get_access_token(code) do
          {:ok, access_token} ->
            save_token(user, access_token)
            render(conn, "index.html")
          {:error, reason} ->
            render(conn, "error.html", reason: reason)
        end
      {:error, reason} ->
        render(conn, "error.html", reason: reason)
    end
  end

  def callback(conn, _params) do
    render(conn, "error.html")
  end

  defp get_access_token(code) do
    params = [
      "grant_type=#{@grant_type}",
      "redirect_uri=#{@redirect_uri}",
      "client_id=#{@client_id}",
      "client_secret=#{@client_secret}",
      "code=#{code}"
    ]
    body = Enum.join(params, "&")

    case HTTPoison.post(@token_url, body, @headers, @options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.inspect body
        access_token = Poison.decode!(body)["access_token"]
        {:ok, access_token}
      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        message = Poison.decode!(body)["message"]
        {:error, message}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp save_token(user, token) do
    service = Repo.get_by(Service, type: 2, name: "line notify")

    user_service_config = %UserServiceConfig{
      user_id: user.id,
      status: "connected",
      service_id: service.id,
      config: Poison.encode!(
        %{
          "line_notify": %{
            "token": token
          }
        })
    }

    Repo.insert(user_service_config,
      on_conflict: :replace_all,
      conflict_target: [:user_id, :service_id]
    )
  end
end
