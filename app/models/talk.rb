class Talk < Event
  validates_presence_of :name

  def session_name
    case start_at.hour
      when 0..11
        "morning"
      when 12..17
        "afternoon"
      when 18..23
        "evening"
      end
  end

  def session
    [ start_at, session_name ]
  end
end
