defmodule Poselink.PostureRecordView do
  use Poselink.Web, :view

  def render("index.json", %{records: records}) do
    %{data: render_many(records, Poselink.PostureRecordView, "record.json")}
  end

  def render("record.json", %{posture_record: %{meta: meta, data: data}}) do
    %{
      id: meta.id,
      width: meta.width,
      height: meta.height,
      insole_size: meta.insole_size,
      posture: %{
        id: meta.posture.id,
        name: meta.posture.name
      },
      datetime: meta.updated_at,
      status: meta.status,
      data: render_many(data, Poselink.PostureRecordDetailView, "record_detail.json")
    }
  end
end
