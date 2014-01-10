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
      if @options[:flags][:type].present?
        args += " -#{@options[:flags][:type].downcase} " 
      else
        args += " -color " 
      end
      args
    end

  end
end
