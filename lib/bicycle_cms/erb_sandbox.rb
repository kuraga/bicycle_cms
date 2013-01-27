require 'erb' # TODO Необходимо?

module BicycleCms
  module ErbSandbox
    # TODO Полноценная песочница

    def eval_in_erb_sandbox(script, binding = nil)
      ERB.new(script, nil, nil, "erbout_#{Random.new.rand(32000)}").result(binding).html_safe
    end

  end
end
