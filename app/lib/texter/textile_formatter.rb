module Texter
  class TextileFormatter < Formatter
    cattr_accessor :rules, :restrictions

    self.rules = []

    # :filter_html
    # :sanitize_html
    # :filter_styles
    # :filter_classes
    # :filter_ids
    # :lite_mode
    # :no_span_caps
    self.restrictions = [:no_span_caps]

    def inline
      restrictions_with_lite_mode = (options[:restrictions] + [:lite_mode]).uniq
      textile :restrictions => restrictions_with_lite_mode
    end

    def block
      textile
    end

    protected

    def textile(redefine_options = {})
      return nil if body.blank?

      redefined_options = options.merge(redefine_options)
      textile = ::RedCloth.new(body, redefined_options[:restrictions])
      textile.to_html(*redefined_options[:rules]).html_safe
    end

    def reverse_merge_defaults
      options.assert_valid_keys(:rules, :restrictions)
      options.reverse_merge!(:rules => rules, :restrictions => restrictions)
    end
  end
end
