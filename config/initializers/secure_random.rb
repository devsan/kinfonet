module SecureRandom
  # Generates a random number with a specified number of digits
  def self.generate_random_number(num_digits = 5)
    starts_at = 10 ** (num_digits - 1)
    ends_at = (10 ** num_digits) - starts_at
    starts_at + SecureRandom.random_number(ends_at)
  end
end