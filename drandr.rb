#!/usr/bin/ruby -w

$DMENU_ARGS = ARGV.join(' ') + '-i -b'

class String
  def starts_with? prefix
    prefix = prefix.to_s
    self[0, prefix.length] == prefix
  end
end

def display prompt, *items
  result = %x{echo "#{items.join "\n"}" | dmenu #{$DMENU_ARGS} -p '#{prompt}'}
  if $? != 0
    exit
  end

  if block_given?
    yield result
  else
    return result
  end
end

def query_xrandr *args
  lines = %x{xrandr #{args.join ' '}}.split $/
  if block_given?
    yield lines
  else
    return lines
  end
end

def get_outputs
  query_xrandr '-q' do |lines|
    lines.delete_at 0
    lines.delete_if {|line| line.starts_with? ' '}
    lines.map! {|line| line.split[0]}
    if block_given?
      yield lines
    else
      return lines
    end
  end
end

def get_output_info output
  query_xrandr '-q' do |lines|
    output_found = false
    lines.delete_at 0
    lines.reject! do |line|
      if output_found
        if line.starts_with? ' '
          false
        else
          output_found = false
          true
        end
      else
        if line.starts_with? output
          output_found = true
          true
        else
          true
        end
      end
    end
    lines.map!{|line| line.split(' ').join(' ')}
    if block_given?
      yield lines
    else
      return lines
    end
  end
end


def main
  display 'Choose an action', %w{Connect Disconnect Resize Rotate Move List} do |command|
    case
    when command == 'Connect'
      display 'Connect which output?', get_outputs do |output|
      end
    when command == 'Disconnect'
      display 'Disconnect which output?', get_outputs do |output|
        query_xrandr '--output', output, '--off'
      end
    when command == 'Resize'
      display 'Resize which output?', get_outputs do |output|
      end
    when command == 'Rotate'
      display 'Rotate which output?', get_outputs do |output|
      end
    when command == 'Move'
      display 'Move which output?', get_outputs do |output|
      end
    when command == 'List'
      display 'Available outputs:', get_outputs do |output|
        get_output_info output do |info|
          resolutions = info.map {|line| line.split(' ')[0]}
          display "#{output} resolutions:", resolutions do |resolution|
            res_line = info.select {|line| line.starts_with? resolution}[0]
            refresh_rates = res_line.split ' '
            refresh_rates.delete_at(0)
            display "#{output}@#{resolution} refresh rates:", refresh_rates
          end
        end
      end
    end
  end
end

main
