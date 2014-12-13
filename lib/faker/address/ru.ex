defmodule Faker.Address.Ru do
  @building_number ["###", "##", "#"]
  @secondary_address ["кв. ###", "кв. ##", "кв. #"]

  def building_number do
    @building_number
    |> Enum.sample
    |> Faker.format
  end

  def secondary_address do
    @secondary_address
    |> Enum.sample
    |> Faker.format
  end

  def zip_code do
    "######"
    |> Faker.format
  end
end
