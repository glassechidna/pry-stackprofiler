require 'net/http'
require 'stackprofx'

class Pry
  Pry.config.hooks.add_hook :after_eval, :stackprofiler do |t|
    Pry::Stackprofiler::try_send
  end

  def self.profile opts={}, &blk
    Pry::Stackprofiler::profile opts, &blk
  end

  module Stackprofiler
    class << self
      @last_profile = nil
      @needs_send = false
      @blk_obj_id = 0

      def profile opts={}, &blk
        # todo: pass through options perhaps?
        opts.merge!({mode: :wall, raw: true})
        @last_profile = StackProfx.run(opts) { blk.call }
        @blk_obj_id = RubyVM::InstructionSequence::of(blk).object_id
        @needs_send = true
      end

      def try_send
        return unless @needs_send
        @needs_send = false

        pry_file = Pry.line_buffer.join
        @last_profile[:files] = {'(pry)' => pry_file}
        @last_profile[:suggested_rebase] = @blk_obj_id

        url = URI::parse ui_url
        headers = {'Content-Type' => 'application/x-ruby-marshal'}
        req = Net::HTTP::Post.new(url.to_s, headers)
        req.body = Marshal.dump @last_profile

        response = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
      end

      def ui_url
        Pry.config.pry_stackprofiler_ui_url ||= ENV['PRY_STACKPROFILER_UI_URL']
      end
    end
  end
end
