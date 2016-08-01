
def set_up_sentiment_analysers
	# Sentimentalizer.setup
	p "setting up afinn"
	afinn_to_hash
	p "afinn done----"

	p "setting up wiebe"
	wiebe_to_hash
	p "wiebe done----"

	p "setting up common words list"
	set_up_common_words_list
	p "list done----"

	p "setting up acronyms"
	set_up_acronyms
	p "acronyms done----"

end

def set_up_common_words_list
	$common_list = {}
	IO.foreach(Padrino.root("public", "ten_thousand_list.txt")) do |x|
		word = x.strip
		$common_list[word]=""
	end
end

def set_up_acronyms
	$acronyms = {}
	IO.foreach(Padrino.root("public", "common_acronyms.txt")) do |x|
		word = x.strip
		$acronyms[word]=""
	end
end

def analyse_headlines_with_brown

	clusters = [10,20,40,60,80,100,120,150,200,500,1000]
	clusters.each do |x|
		`./wcluster --text test.txt --c #{x}`
	end

	# https://github.com/percyliang/brown-cluster

	# http://www.derczynski.com/sheffield/brown-tuning/
	# Low cluster counts and small input corpora both lead to poor quality Brown clusterings. But this isn't very useful general advice. We need to look deeper. We'll change to recognising named entities in news text, because we have bigger and more reliable data in this area, which improves the stability and resolution of the performance scores.
	
end

def analyse_brown_output
	 hash = {}
        Dir.glob("./lib/brown-cluster/*.out/paths").each do |file|
            f = File.dirname(file)
            write = File.open("#{f}/readable.txt","w")
            File.open(file,"r").readlines.each do |line, line_num|

                binary,word,group = line.split("\t")
                group.strip!
                word.strip!

                if !hash.has_key?(group)
                  hash[group] = [word]
                else
                  arr = hash[group]
                  arr << word
                  hash[group] = arr
                end
            end

            hash.each_pair do |k,v|
              write.puts(k)
              write.printf("#{v}\n\n")
            end
            write.close
        end
end

def afinn_to_hash
	$afinn = {}
	IO.foreach(Padrino.root("public", "AFINN-111.txt")) do |x|
		word, score = x.split(",")
		$afinn[word]=score.strip.to_i 
	end
end

def wiebe_to_hash
	$wiebe = {}
	IO.foreach(Padrino.root("public", "subjectivity_lexicon_opinion_finder.txt")) do |x|
		t={:pos=>'',:sentiment=>0}

		sentiment = 0
		strength,word,t[:pos],sentiment_word = x.split(" ")

		case sentiment_word.strip
		when "positive"
			sentiment=2.0
		when "negative"
			sentiment=-2.0
		end

		case strength
		when "strongsubj"
			t[:sentiment]=sentiment*2
		else
			t[:sentiment]=sentiment
		end

		$wiebe[word]= t
	end
end

def formatforD3(obj)

	s = []
	total = obj.values.inject(:+)

	obj.each_pair do |k,v|
	
		h = {}
		h['lang']=k
		h['amount']=(100.0*v/total).round(2)
		s << h
	end

	return s
end



