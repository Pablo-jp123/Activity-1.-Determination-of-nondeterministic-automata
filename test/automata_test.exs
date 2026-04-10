defmodule AutomataTest do
  use ExUnit.Case

  test "determinize works" do
    nfa = %{
      states: [:q0, :q1],
      alphabet: [:a],
      transitions: %{
        {:q0, :a} => [:q0, :q1]
      },
      start: :q0,
      accept: [:q1]
    }

    dfa = Automata.determinize(nfa)

    assert dfa != nil
  end
end
