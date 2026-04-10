defmodule Automata do
  def determinize(nfa) do
    start = MapSet.new([nfa.start])

    build_dfa([start], MapSet.new([start]), %{}, nfa, [])
  end

  defp build_dfa([], visited, transitions, nfa, finals) do
    %{
      states: MapSet.to_list(visited),
      alphabet: nfa.alphabet,
      transitions: transitions,
      start: MapSet.new([nfa.start]),
      accept: finals
    }
  end

  defp build_dfa([current | rest], visited, transitions, nfa, finals) do
    {new_transitions, new_states} =
      Enum.reduce(nfa.alphabet, {transitions, []}, fn symbol, {trans_acc, states_acc} ->
        next =
          current
          |> Enum.flat_map(fn state ->
            Map.get(nfa.transitions, {state, symbol}, [])
          end)
          |> MapSet.new()

        trans_acc = Map.put(trans_acc, {current, symbol}, next)

        if MapSet.member?(visited, next) or MapSet.size(next) == 0 do
          {trans_acc, states_acc}
        else
          {trans_acc, [next | states_acc]}
        end
      end)

    visited = Enum.reduce(new_states, visited, fn s, acc -> MapSet.put(acc, s) end)

    finals =
      if Enum.any?(current, fn s -> s in nfa.accept end) do
        [current | finals]
      else
        finals
      end

    build_dfa(rest ++ new_states, visited, new_transitions, nfa, finals)
  end
end
