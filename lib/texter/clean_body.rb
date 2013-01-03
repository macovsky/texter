module Texter
  class CleanBody < Struct.new(:text)
    def clean(*attrs)
      attrs.flatten.each do |attr|
        if (value = text.send(attr)).present?
          text.send("#{attr}=", value.gsub(/\r/, ''))
        end
      end
    end
  end
end
