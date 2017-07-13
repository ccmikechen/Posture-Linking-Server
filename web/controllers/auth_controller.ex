defmodule Poselink.AuthController do
  use Poselink.Web, :controller

  alias Poselink.Service

  def authorize(conn, %{"access_token" => token, "serviceId" => service_id}) do
    service = Repo.get(Service, service_id)
    IO.puts token
    case Guardian.serializer.from_access_token(token) do
      {:ok, user} ->
        render(conn, "index.html",
          token: token,
          service_type: service.type,
          service_name: service.name)
      {:error, reason} ->
        render(conn, "error.html", reason: reason)
    end
  end
end
