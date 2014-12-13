defmodule Faker.Address.EnUS do
  @building_number ["#####", "####", "###", "##", "#"]
  @secondary_address ["Apt. ###", "Apt. ##", "Apt. #", "Suite ###", "Suite ##", "Suite #"]
  @zip_code ["#####", "#####-####"]

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
    @building_number
    |> Enum.sample
    |> Faker.format
  end

  def city do
    [
      "#{Faker.Address.city_prefix} #{Faker.Name.first_name}#{Faker.Address.city_suffix}",
      "#{Faker.Address.city_prefix} #{Faker.Name.first_name}",
      "#{Faker.Name.first_name}#{Faker.Address.city_suffix}",
      "#{Faker.Name.last_name}#{Faker.Address.city_suffix}"
    ]
    |> Enum.sample
  end
end
