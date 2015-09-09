class Orderbook
  module History
    class Candle

      attr_reader :time, :low, :high, :open, :close, :volume

      def initialize(epoch, matches)
        @time = epoch
        @low = matches.map {|message| BigDecimal.new(message.fetch('price'))}.min
        @high = matches.map {|message| BigDecimal.new(message.fetch('price'))}.max
        @open = BigDecimal.new(matches.first.fetch('price'))
        @close = BigDecimal.new(matches.last.fetch('price'))
        @volume = matches.reduce(BigDecimal(0)) {|sum, message| sum + BigDecimal.new(message.fetch('size'))}
      end

      def to_h
        {
          start:  Time.at(@time),
          low:    @low.to_s("F"),
          high:   @high.to_s("F"),
          open:   @open.to_s("F"),
          close:  @close.to_s("F"),
          volume: @volume.to_s("F"),
        }
      end
    end
  end
end