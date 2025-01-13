class String
  def presence
    strip.empty? ? nil : self
  end
end
