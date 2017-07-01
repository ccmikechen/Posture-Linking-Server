defmodule Poselink.NotificationLog do
  use Poselink.Web, :model

  schema "notification_logs" do
    field :message, :string
    belongs_to :notification_type, Poselink.NotificationType

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message])
    |> validate_required([:message])
  end
end
