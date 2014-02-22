module PodLibrariesHelper
  ICON_CLASSES = {
    popularity:   'fi-heart',
    contributors: 'fi-social-github',
    stars:        'fi-star',
    last_commit:  'fi-clock',
  }.freeze
  def icon_class(order_type)
    ICON_CLASSES[order_type.to_sym]
  end
end
