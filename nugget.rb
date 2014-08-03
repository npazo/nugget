
# path to the thumbnails with no trailing slash
$thumbs_dir = "/path/to/thumbnails"

# path to the full size photos with a trailing slash
$full_dir = "/path/to/photo_export/"

def read_dir (dir, output, index, full_dir_path)
  count = 0		# keeps track of pictures in a row so it knows when to create a new one
  pic_count = 0
  first_month = true
  first_year = true
  Dir.glob("#{dir}/*").each_with_object({}) do |f, h|
    if File.file?(f)
      if count == 0
        output << "<div class=\"shell\">"
        output << "<div class=\"turtle\">"
      end
      output << "<a class=\"nugget\" href=\"" + full_dir_path + File.basename(f) + "\"><img class=\"nugget_img\" src=\"" + f + "\"/></a>"
      count += 1
      pic_count += 1
      if count == 7		# time to end the row
        output << "</div></div>"
        count = 0
      end
    elsif File.directory?(f)

      if File.basename(f).include? "-"	# this is how it checks for a month folder
        if count > 0 
          count = 0
        end
      
        if !first_month
           output << "</div></div>"	# end the month as long as there is one
        end
        output << "<h2>" + File.basename(f) + "</h2>"
       
        first_month = false
      else # if its a top level year
        
        index << "<h1><a href=\"" + File.basename(f) + ".html\">" + File.basename(f) + "</a></h1>"
         
        if !first_year
          output << "</div></div>"
          output << "</div>"
          output << "<div id=\"nav\">"
          output << "<div id=\"prev\"><a href=\"" + (File.basename(f).to_i - 1).to_s + ".html" + "\"><< Prev</a></div>"
          output << "<div id=\"next\"><a href=\"" + File.basename(f) + ".html" + "\">Next >></a></div>"
          output << "</div>"
          output.close
        end
  
        output = File.open( File.basename(f) + ".html", "w" )
        
        output << "<html>"
        output << "<head>"
        output <<  "<script type=\"text/javascript\" src=\"jquery.min.js\"></script>"
        output <<  "<script type=\"text/javascript\" src=\"nugget.js\"></script>"
        output <<   "<link rel=\"stylesheet\" type=\"text/css\" href=\"nugget.css\"/>"
        output << "</head>"
        output << "<body>"
        output << "<div id=\"main\">"
        
  
        output << "<h1>" + File.basename(f) + "</h1>"
        first_year = false
      end
        read_dir(f, output, index, full_dir_path + File.basename(f) + "/")
    end
  end
end

index = File.open( "index.html", "w" )
output = index

index << "<html>"
index << "<head>"
index <<  "<script type=\"text/javascript\" src=\"jquery.min.js\"></script>"
index <<  "<script type=\"text/javascript\" src=\"nugget.js\"></script>"
index <<   "<link rel=\"stylesheet\" type=\"text/css\" href=\"nugget.css\"/>"
index << "</head>"
index << "<body>"

read_dir($thumbs_dir, output, index, $full_dir)

# close the last month
output << "</div></div></body>"
output << "</html>"

output.close
