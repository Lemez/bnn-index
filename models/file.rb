def write_stories_title_to_file
	 file = File.open("test.txt","w")
	    Story.all.each do |s|
	      file.puts(s.title)
	    end
    file.close
end