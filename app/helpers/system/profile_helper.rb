module System::ProfileHelper

  class ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Context

    def location_field(options = {})
      obj = object
      lat, lng = nil

      if obj.present? && obj.location_set?
        lat = obj.lat
        lng = obj.lng
      else
        if options.key? :default
          default = options[:default]

          if default.key?(:lat) && default.key?(:lng)
            lat = default[:lat]
            lng = default[:lng]
          else
            raise 'You have not provided lat and/or lng in location field default attribute'
          end
        end
      end

      @template.content_tag(:div) do
        hidden_field('lat', value: lat) + hidden_field('lng', value: lng)
      end

    end
  end

end
