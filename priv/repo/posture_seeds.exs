import Ecto.Query

alias Poselink.Repo
alias Poselink.Posture
alias Poselink.PostureClassification

static_type = 1
dynamic_short_type = 2
dynamic_lone_type = 3

standing = [
  %{
    name: "standing",
    type: static_type
  }
]

sitting = [
  %{
    name: "sitting",
    type: static_type
  }
]

lying = [
  %{
    name: "lying",
    type: static_type
  }
]

walking = [
  %{
    name: "walking",
    type: dynamic_lone_type
  }
]

postures = %{
  "standing" => standing,
  "sitting" => sitting,
  "lying" => lying,
  "walking" => walking
}

postures
|> Enum.to_list()
|> Enum.each(fn {c, p} ->
  classification =
    %PostureClassification{name: c}
    |> Repo.insert!(on_conflict: :nothing, conflict_target: [:name])

  Enum.each(p, fn %{name: name, type: type} ->
    Repo.insert(
      %Posture{
        name: name,
        classification_id: classification.id,
        type: type
      },
      on_conflict: :nothing,
      conflict_target: [:name]
    )
  end)
end)
