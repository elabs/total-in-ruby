require "total_in/line_handlers"
require "total_in/contexts"

module TotalIn
  class Parser
    attr_reader :text

    def initialize text
      @text = text
    end

    def result
      contexts = parse_lines text.each_line.to_a, Contexts.new

      contexts.result
    end

    private

    def parse_lines lines, contexts
      if line = lines.shift
        parse_lines lines, parse_line(line, contexts)
      else
        contexts
      end
    end

    def parse_line line, contexts
      handler = handler_for_line line

      handler.process line, contexts
    end

    def handler_for_line line
      LineHandlers.mapping.fetch line[0..1]
    end
  end
end
