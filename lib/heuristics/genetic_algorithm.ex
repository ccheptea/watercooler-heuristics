defmodule Heuristics.GeneticAlgorithm do
  @behaviour Heuristic

  @type state :: Heuristic.state
  @type fitness_func :: Heuristic.fitness_func

  @opts %{
    iterations: 100,
    population_size: 100
  }

  @spec start(state, fitness_func, any()) :: state
  def start(initial_state, fitness_func, opts \\ @opts) do
    population = generate_initial_population(initial_state, opts[:population_size])

    0..opts[:iterations]
      |> Enum.to_list()
      |> Enum.reduce(population, fn index, population ->
        elite = select(population, fitness_func)
        fittest = Enum.at(elite, 0)
        fittest_score = fitness_func.(fittest)

        IO.puts "Generation\t#{index}\t#{fittest_score}"

        evolve(population)
      end)
      |> select(fitness_func)
      |> Enum.at(0)
  end

  def generate_initial_population(eve, size \\ 100) do
    1..size
      |> Enum.map(fn _ -> Enum.shuffle(eve) end)
  end

  def evolve(elite) do
    elite_count = length(elite)
    offsprings =
      1..100
      |> Enum.to_list()
      |> Enum.map(fn _ ->
        p1_index = :rand.uniform(elite_count) - 1
        p2_index = :rand.uniform(elite_count) - 1
        p1 = Enum.at(elite, p1_index)
        p2 = Enum.at(elite, p2_index)

        mate(p1, p2)
      end)

    elite ++ offsprings
  end

  def mate(parent1, parent2) do
    count = length(parent1)

    slice_start = :rand.uniform(count) - 1
    slice_amount = :rand.uniform(count - slice_start) - 1
    slice = Enum.slice(parent1, slice_start, slice_amount)
    {head, tail} = parent2
      |> Enum.filter(fn x -> not Enum.member?(slice, x) end)
      |> Enum.split(slice_start)

    offspring = head ++ slice ++ tail
    if :rand.uniform() > 0.7 do
      offspring
      |> mutate()
    else
      offspring
    end
  end

  def select(population, fitness_func) do
    population
      |> Enum.map(fn x -> {x, fitness_func.(x)} end)
      |> Enum.sort(fn {_, left}, {_, right} -> left >= right end)
      |> Enum.take(30)
      |> Enum.map(fn {x, _} -> x end)
  end

  def mutate(individual) do
    count = length(individual)

    first_index = :rand.uniform(count) - 1
    second_index = :rand.uniform(count) - 1

    ListHelper.swap(individual, first_index, second_index)
  end

end
