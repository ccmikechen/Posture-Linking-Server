defmodule Poselink.PostureRecordView do
  use Poselink.Web, :view

  def render("index.json", %{records: records}) do
    %{data: render_many(records, Poselink.PostureRecordView, "record.json")}
  end

  def render("record.json", %{posture_record: record}) do
    %{
      id: record.id,
      weight: record.weight,
      height: record.height,
      insole_size: record.insole_size,
      posture: %{
        id: record.posture.id,
        name: record.posture.name
      },
      datetime: record.updated_at,
      status: record.status
    }
  end
end
