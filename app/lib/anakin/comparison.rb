module Anakin
  class Comparison < Base

    protected
    

    def build_specific_args
      args = ""
      args += " -min #{@options[:flags][:min]} " if @options[:flags][:min].present?
      args
    end

    def pattern_dir
      File.join(Rails.root, "public", "uploads", "pattern", @options[:user].id.to_s, 'comparison')
    end
  end
end
