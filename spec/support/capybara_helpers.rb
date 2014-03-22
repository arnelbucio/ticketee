def state_line_for(state)
  state = State.find_by_name!(state)
  "#state_#{state.id}"
end
