alias Poselink.Repo
alias Poselink.Posture
alias Poselink.PostureClassification

static_type = 1
dynamic_short_type = 2
dynamic_long_type = 3

standing = [
  %{
    name: "standing",
    type: static_type
  },
  %{
    name: "shaking hand when standing",
    type: dynamic_short_type
  },
  %{
    name: "jumping",
    type: dynamic_short_type
  },
  %{
    name: "claping hands when standing",
    type: dynamic_short_type
  },
  %{
    name: "right step when standing",
    type: dynamic_short_type
  },
  %{
    name: "left step when standing",
    type: dynamic_short_type
  }
]

sitting = [
  %{
    name: "sitting",
    type: static_type
  },
  %{
    name: "shaking hand when sitting",
    type: dynamic_short_type
  },
  %{
    name: "claping hands when sitting",
    type: dynamic_short_type
  },
  %{
    name: "right step when sitting",
    type: dynamic_short_type
  },
  %{
    name: "left step when sitting",
    type: dynamic_short_type
  },
  %{
    name: "cross right leg",
    type: static_type
  },
  %{
    name: "cross left leg",
    type: static_type
  },
  %{
    name: "play computer",
    type: static_type
  }
]

lying = [
  %{
    name: "lying down",
    type: static_type
  },
  %{
    name: "lying on front",
    type: static_type
  }
]

walking = [
  %{
    name: "walking",
    type: dynamic_long_type
  },
  %{
    name: "running",
    type: dynamic_long_type
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
