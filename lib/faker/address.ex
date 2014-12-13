defmodule Faker.Address do
  defdelegate postcode, to: Faker.Address, as: :zip_code
  defdelegate zip, to: Faker.Address, as: :zip_code

  def building_number(locale \\ Faker.Address.EnUS)

  def building_number(locale) when is_atom(locale) do
    locale.building_number
  end

  def building_number(locale) when is_binary(locale) do
    "Elixir.Faker.Address.#{String.capitalize(locale)}"
    |> String.to_existing_atom
    |> apply(:building_number, [])
  end

  def secondary_address(locale \\ Faker.Address.EnUS)

  def secondary_address(locale) when is_atom(locale) do
    locale.secondary_address
  end

  def secondary_address(locale) when is_binary(locale) do
    "Elixir.Faker.Address.#{String.capitalize(locale)}"
    |> String.to_existing_atom
    |> apply(:secondary_address, [])
  end

  def zip_code(locale \\ Faker.Address.EnUS)

  def zip_code(locale) when is_atom(locale) do
    locale.zip_code
  end

  def zip_code(locale) when is_binary(locale) do
    "Elixir.Faker.Address.#{String.capitalize(locale)}"
    |> String.to_existing_atom
    |> apply(:zip_code, [])
  end

  data_path = Path.expand(Path.join(__DIR__, "../../priv/address.json"))
  json = File.read!(data_path) |> Poison.Parser.parse!
  Enum.each json, fn(el) ->
    {lang, data} = el
    Enum.each data, fn
      {"values", values} ->
        Enum.each values, fn({fun, list}) ->
          def unquote(String.to_atom(fun))() do
            unquote(String.to_atom("get_#{fun}"))(Faker.locale, :crypto.rand_uniform(0, unquote(String.to_atom("#{fun}_count"))(Faker.locale)))
          end
          defp unquote(String.to_atom("#{fun}_count"))(unquote(String.to_atom(lang))) do
            unquote(Enum.count(list))
          end
          Enum.with_index(list) |> Enum.each fn({el, index}) ->
            defp unquote(String.to_atom("get_#{fun}"))(unquote(String.to_atom(lang)), unquote(index)) do
              unquote(el)
            end
          end
        end
      {"functions", values} ->
        Enum.each values, fn({fun, list}) ->
          def unquote(String.to_atom(fun))() do
            unquote(String.to_atom(fun))(Faker.locale, :crypto.rand_uniform(0, unquote(String.to_atom("#{fun}_count"))(Faker.locale)))
          end
          Enum.with_index(list) |> Enum.each fn({el, index}) ->
            defp unquote(String.to_atom(fun))(unquote(String.to_atom(lang)), unquote(index)) do
              unquote(Code.string_to_quoted!('"#{el}"'))
            end
          end
          defp unquote(String.to_atom("#{fun}_count"))(unquote(String.to_atom(lang))) do
            unquote(Enum.count(list))
          end
        end
    end
  end

  def latitude do
    :random.seed(:erlang.now)
    ((:random.uniform * 180) - 90)
  end

  def longitude do
    :random.seed(:erlang.now)
    ((:random.uniform * 360) - 180)
  end

  def street_address(true), do: street_address <> " " <> secondary_address
  def street_address(_), do: street_address
end
