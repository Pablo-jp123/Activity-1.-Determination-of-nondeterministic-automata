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

  test "e_closure works" do
    nfa = %{
      states: [:q0, :q1, :q2],
      alphabet: [:a],
      transitions: %{
        {:q0, :epsilon} => [:q1],
        {:q1, :epsilon} => [:q2]
      },
      start: :q0,
      accept: [:q2]
    }

    result = Automata.e_closure(nfa, [:q0])

    assert MapSet.equal?(result, MapSet.new([:q0, :q1, :q2]))
  end
end
