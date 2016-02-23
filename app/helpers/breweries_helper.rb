module BreweriesHelper

  def round(n)
    number_with_precision(n, precision: 1)                           # => 111.23
  end
end
