defmodule Poselink.ActionService.LineNotifyAction do
  use GenServer

  alias Poselink.Repo
  alias Poselink.UserServiceConfig

  @url "https://notify-api.line.me/api/notify"
  @options [ssl: [versions: [:"tlsv1.2"]], recv_timeout: 500]

  def start_link(service_id) do
    GenServer.start_link(__MODULE__, service_id, [name: __MODULE__])
  end

  def execute(user, payload, config) do
    GenServer.cast(__MODULE__, {:execute, user, payload, config})
  end

  def handle_cast({:execute, user, payload, config}, service_id) do
    %{"line_notify" => %{"token" => token}} =
      UserServiceConfig
      |> Repo.get_by!(user_id: user.id, service_id: service_id)
      |> Map.get(:config)
      |> Poison.decode!

    %{"content" => message} = config

    message
    |> Poselink.ActionService.combine_message_and_payload(payload)
    |> send_line_notify(token)

    {:noreply, service_id}
  end

  defp send_line_notify(message, access_token) do
    headers = [
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer #{access_token}"
    ]
    body = "message=#{message}"

    HTTPoison.post(@url, body, headers, @options)
  end
end
