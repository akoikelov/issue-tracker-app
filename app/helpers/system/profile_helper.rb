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
        gmaps_key = ENV['GOOGLE_MAPS_KEY']

        fields = hidden_field('lat', value: lat, 'data-name': 'lat') + hidden_field('lng', value: lng, 'data-name': 'lng')
        map = @template.content_tag(:div, class: 'map', id: 'map', width: '300px', height: '300px') {}
        profile_script = @template.content_tag(:script, src: '/assets/system/profile.js') {}
        gmaps_script = @template.content_tag(:script, src: raw("https://maps.googleapis.com/maps/api/js?key=#{gmaps_key}&callback=initMap")) {}

        fields + map + raw(profile_script + gmaps_script)
      end

    end
  end

end
