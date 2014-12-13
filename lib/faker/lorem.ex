defmodule Faker.Lorem do
  @words ["alias", "consequatur", "aut", "perferendis", "sit", "voluptatem", "accusantium", "doloremque", "aperiam", "eaque", "ipsa", "quae", "ab", "illo", "inventore", "veritatis", "et", "quasi", "architecto", "beatae", "vitae", "dicta", "sunt", "explicabo", "aspernatur", "aut", "odit", "aut", "fugit", "sed", "quia", "consequuntur", "magni", "dolores", "eos", "qui", "ratione", "voluptatem", "sequi", "nesciunt", "neque", "dolorem", "ipsum", "quia", "dolor", "sit", "amet", "consectetur", "adipisci", "velit", "sed", "quia", "non", "numquam", "eius", "modi", "tempora", "incidunt", "ut", "labore", "et", "dolore", "magnam", "aliquam", "quaerat", "voluptatem", "ut", "enim", "ad", "minima", "veniam", "quis", "nostrum", "exercitationem", "ullam", "corporis", "nemo", "enim", "ipsam", "voluptatem", "quia", "voluptas", "sit", "suscipit", "laboriosam", "nisi", "ut", "aliquid", "ex", "ea", "commodi", "consequatur", "quis", "autem", "vel", "eum", "iure", "reprehenderit", "qui", "in", "ea", "voluptate", "velit", "esse", "quam", "nihil", "molestiae", "et", "iusto", "odio", "dignissimos", "ducimus", "qui", "blanditiis", "praesentium", "laudantium", "totam", "rem", "voluptatum", "deleniti", "atque", "corrupti", "quos", "dolores", "et", "quas", "molestias", "excepturi", "sint", "occaecati", "cupiditate", "non", "provident", "sed", "ut", "perspiciatis", "unde", "omnis", "iste", "natus", "error", "similique", "sunt", "in", "culpa", "qui", "officia", "deserunt", "mollitia", "animi", "id", "est", "laborum", "et", "dolorum", "fuga", "et", "harum", "quidem", "rerum", "facilis", "est", "et", "expedita", "distinctio", "nam", "libero", "tempore", "cum", "soluta", "nobis", "est", "eligendi", "optio", "cumque", "nihil", "impedit", "quo", "porro", "quisquam", "est", "qui", "minus", "id", "quod", "maxime", "placeat", "facere", "possimus", "omnis", "voluptas", "assumenda", "est", "omnis", "dolor", "repellendus", "temporibus", "autem", "quibusdam", "et", "aut", "consequatur", "vel", "illum", "qui", "dolorem", "eum", "fugiat", "quo", "voluptas", "nulla", "pariatur", "at", "vero", "eos", "et", "accusamus", "officiis", "debitis", "aut", "rerum", "necessitatibus", "saepe", "eveniet", "ut", "et", "voluptates", "repudiandae", "sint", "et", "molestiae", "non", "recusandae", "itaque", "earum", "rerum", "hic", "tenetur", "a", "sapiente", "delectus", "ut", "aut", "reiciendis", "voluptatibus", "maiores", "doloribus", "asperiores", "repellat"]

  def word do
    :random.seed(:os.timestamp)
    @words |> Enum.sample
  end

  def characters(range \\ %Range{first: 15, last: 255})

  def characters(%Range{first: first, last: last}) do
    characters(:crypto.rand_uniform(first, last+1))
  end

  def characters(num) do
    Stream.repeatedly(&character/0)
    |> Enum.take(num)
  end

  def paragraph(range \\ %Range{first: 2, last: 5})

  def paragraph(%Range{first: first, last: last}) do
    paragraph(:crypto.rand_uniform(first, last+1))
  end

  def paragraph(num) do
    sentences(num)
    |> Enum.join(" ")
  end

  def paragraphs(range \\ %Range{first: 2, last: 5})

  def paragraphs(%Range{first: first, last: last}) do
    paragraphs(:crypto.rand_uniform(first, last+1))
  end

  def paragraphs(num) do
    Stream.repeatedly(&paragraph/0)
    |> Enum.take(num)
  end

  def sentence(range \\ %Range{first: 4, last: 10})

  def sentence(%Range{first: first, last: last}) do
    sentence(:crypto.rand_uniform(first, last+1), hd(Enum.shuffle([".", ".", ".", "!", "?"])))
  end

  def sentence(num) do
    sentence(num, hd(Enum.shuffle([".", ".", ".", "!", "?"])))
  end

  def sentence(num, mark) when is_integer(num) and is_binary(mark) do
    tmp = words(num)
    |> Enum.join(" ")
    |> String.capitalize
    tmp <> mark
  end

  def sentences(range \\ %Range{first: 2, last: 5})

  def sentences(%Range{first: first, last: last}) do
    sentences(:crypto.rand_uniform(first, last+1))
  end

  def sentences(num) do
    Stream.repeatedly(&sentence/0)
    |> Enum.take(num)
  end

  def words(range \\ %Range{first: 3, last: 6})

  def words(%Range{first: first, last: last}) do
    words(:crypto.rand_uniform(first, last+1))
  end

  def words(num) do
    Stream.repeatedly(&word/0)
    |> Enum.take(num)
  end

  defp character do
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    Enum.at(alphabet, :crypto.rand_uniform(0, Enum.count(alphabet)))
  end
end
