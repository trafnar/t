require 't/core_ext/string'
require 't/rcfile'
require 't/requestable'
require 'thor'

module T
  class CLI
    class Set < Thor
      include T::Requestable

      check_unknown_options!

      def initialize(*)
        super
        @rcfile = RCFile.instance
      end

      desc "bio DESCRIPTION", "Edits your Bio information on your Twitter profile."
      def bio(description)
        client.update_profile(:description => description, :include_entities => false)
        say "@#{@rcfile.default_profile[0]}'s bio has been updated."
      end

      desc "default SCREEN_NAME [CONSUMER_KEY]", "Set your default account."
      def default(screen_name, consumer_key=nil)
        screen_name = screen_name.strip_at
        @rcfile.path = parent_options['profile'] if parent_options['profile']
        consumer_key = @rcfile[screen_name].keys.last if consumer_key.nil?
        @rcfile.default_profile = {'username' => screen_name, 'consumer_key' => consumer_key}
        say "Default account has been updated."
      end

      desc "language LANGUAGE_NAME", "Selects the language you'd like to receive notifications in."
      def language(language_name)
        client.settings(:lang => language_name)
        say "@#{@rcfile.default_profile[0]}'s language has been updated."
      end

      desc "location PLACE_NAME", "Updates the location field in your profile."
      def location(place_name)
        client.update_profile(:location => place_name, :include_entities => false)
        say "@#{@rcfile.default_profile[0]}'s location has been updated."
      end

      desc "name NAME", "Sets the name field on your Twitter profile."
      def name(name)
        client.update_profile(:name => name, :include_entities => false)
        say "@#{@rcfile.default_profile[0]}'s name has been updated."
      end

      desc "url URL", "Sets the URL field on your profile."
      def url(url)
        client.update_profile(:url => url, :include_entities => false)
        say "@#{@rcfile.default_profile[0]}'s URL has been updated."
      end

    end
  end
end
