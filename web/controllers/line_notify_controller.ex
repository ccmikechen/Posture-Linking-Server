defmodule Poselink.LineNotifyController do
  use Poselink.Web, :controller

  def callback(conn, %{"code" => code, "state" => token}) do
    case Guardian.serializer.from_access_token(token) do
      {:ok, user} ->
        IO.puts "user: #{user.username} code: #{code}"
        render(conn, "index.html")
      {:error, reason} ->
        render(conn, "error.html", reason: reason)
    end
  end

  def token(conn) do
    render(conn, "token.html")
  end
end
