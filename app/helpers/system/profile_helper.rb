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
        gmaps_key = Rails.application.config.gmaps_key

        fields = hidden_field('lat', value: lat, 'data-name': 'lat') + hidden_field('lng', value: lng, 'data-name': 'lng')
        map = @template.content_tag(:div, id: 'map', 'data-gmaps-key': gmaps_key) {}
        profile_script = @template.content_tag(:script, src: '/assets/system/profile.js') {}

        fields + map + raw(profile_script)
      end

    end
  end

end
