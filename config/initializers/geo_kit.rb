require 'rubygems'
require 'geokit'
require 'geokit-rails'
# Geokit::Geocoders::YAHOO=’REPLACE_WITH_YOUR_YAHOO_KEY’
Geokit::Geocoders::GOOGLE='AIzaSyCXh9eRpacVz8rPG-AcFLtj1AHZ7fdU1I4'
#AIzaSyCXh9eRpacVz8rPG-AcFLtj1AHZ7fdU1I4
#AIzaSyCVXavl3GCSme3nf0sNktXdXUVZpJJkGQc
Geokit::Geocoders::GEOCODER_US=false
Geokit::Geocoders::GEOCODER_CA=false
Geokit::Geocoders::PROVIDER_ORDER=[:google,:br]