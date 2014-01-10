module Anakin
  class Landscape < Comparison
    
    protected

    def build_specific_args
      args = " -landscape "
      args += super
      args += " -minMax #{@options[:flags][:min_max]} " if @options[:flags][:min_max].present?
      args += " -avg #{@options[:flags][:avg]} " if @options[:flags][:avg].present?
      args += " -safeOffset #{@options[:flags][:safe_offset]} " if @options[:flags][:safe_offset].present?
      args += " -label #{@options[:flags][:label]} " if @options[:flags][:label].present?
      if @options[:flags][:gray].present?
        args += " -gray " 
      elsif @options[:flags][:color].present?
        args += " -color " 
      elsif @options[:flags][:hsv].present?
        args += " -hsv " 
      else
        args += " -color " 
      end
      args
    end

  end
end
