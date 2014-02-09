module ApplicationHelper
  def time_ago(datetime)
    datetime ? time_ago_in_words(datetime) + ' ago' : '-'
  end
end
