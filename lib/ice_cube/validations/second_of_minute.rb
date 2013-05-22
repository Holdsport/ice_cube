module IceCube

  module Validations::SecondOfMinute

    def second_of_minute(*seconds)
      seconds.each do |second|
        validations_for(:second_of_minute) << Validation.new(second)
      end
      clobber_base_validations :sec
      self
    end

    class Validation

      include Validations::Lock

      StringBuilder.register_formatter(:second_of_minute) do |segments|
        str = "#{I18n.t("ice_cube.on_the")} #{StringBuilder.sentence(segments)} "
        str << (segments.size == 1 ? I18n.t("ice_cube.seconds_of_minute.one") : I18n.t("ice_cube.seconds_of_minute.default"))
      end

      attr_reader :second
      alias :value :second

      def initialize(second)
        @second = second
      end

      def type
        :sec
      end

      def build_s(builder)
        builder.piece(:second_of_minute) << StringBuilder.nice_number(second)
      end

      def build_hash(builder)
        builder.validations_array(:second_of_minute) << second
      end

      def build_ical(builder)
        builder['BYSECOND'] << second
      end

    end

  end

end
