require "mini_magick"

# put the directory to the source photos with no trailing slash
$input_dir = "/path/to/photos"

# put the destination directory for thumbnails. it should *not* be within the directory above
$output_dir = "/destination/for/thumbnails/"

def read_dir (dir, output)
  Dir.glob("#{dir}/*").each_with_object({}) do |f, h|
    if File.file?(f)
        if %w(.jpg .jpeg .png).include? File.extname(f).downcase
          if !File.exists?(output + File.basename(f))
            image = MiniMagick::Image.open(f)   
            image.auto_orient            
  
	
            if image[:width].to_f/image[:height].to_f > (4.0/3.0) # shrink width
              width = image[:height] * 1.333
              height = image[:height]
            else  # shrink height
              width = image[:width]
              height = image[:width] * 0.75          
            end 
            image.combine_options do |c|
              c.gravity "center"
              c.crop width.floor.to_s + "x" + height.floor.to_s + "+0+0"
              c.repage.+
              c.thumbnail "300x225!"
            end
            puts output + File.basename(f)
            image.write output + File.basename(f)
          end
        end

    elsif File.directory?(f)
        if !File.exists?(output + File.basename(f))
          Dir.mkdir(output + File.basename(f) + "/")
        end
        read_dir(f, output + File.basename(f) + "/")
    end
  end
end

read_dir($input_dir, $output_dir)
