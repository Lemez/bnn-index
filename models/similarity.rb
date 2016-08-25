# require 'similarity'
require 'matrix'
require 'tf-idf-similarity'

def set_up_uniqish
	@corpus = Corpus.new
	@reject = []
end

def set_up_tfidf
	@corpus = []
	@reject = []
end

def get_uniqish_titles(objarray)

	array = objarray.map(&:title)
	results = remove_similar(array)
	return array - results
end

def is_uniqish_enough?(stories,mainstory)
	set_up_uniqish

	@doc1 = Document.new(:content=>mainstory.title)
	@corpus << @doc1

	stories.each{|story| @corpus << Document.new(:content=>story.title)}
	@similarity_count = 0

	@corpus.similar_documents(@doc1).each do |doc, similarity|
		if similarity > 0.5 && !$passed.include?(@doc1.content)

				@similarity_count += 1 
				$passed << @doc1.content
		end
	end

	@similarity_count < 1 ? result=false : result=true
	p " #{result}: #{@similarity_count}: #{@doc1.content}"

	result
end

def is_uniqish_enough_by_tfidf?(stories,mainstory)

	set_up_tfidf

	title = mainstory.title.remove_stopwords

	@doc1 = TfIdfSimilarity::Document.new(title)
	@corpus << @doc1

	stories.each{|story| @corpus << TfIdfSimilarity::Document.new(story.title.remove_stopwords)}
	@similarity_count = 0


	model = TfIdfSimilarity::TfIdfModel.new(@corpus)
	matrix = model.similarity_matrix

	@corpus.each_with_index do |doc, index|
		similarity =  matrix[model.document_index(doc),model.document_index(@doc1)]

		if similarity > SIMILARITY_THRESHOLD && !$passed.include?(@doc1.text)

				@similarity_count += 1 
				$passed << @doc1.text
				p "#{similarity.round(1)} - #{mainstory.source} -  - #{mainstory.id} - #{mainstory.title}:#{doc.text} "
		end
	end

	@similarity_count != 1 ? result=false : result=true
	# p " #{result}: #{@similarity_count}: #{@doc1.text}"

	result
end

def remove_similar(array)
	set_up_uniqish

	array.each_with_index{|title,i| @corpus << Document.new(:content=>title)}

	# each doc should only be similar with itself - ie each unique doc should have similarity ~1 once
	@corpus.documents.each do |document|
		@corpus.similar_documents(document).each do |doc, similarity|
		
			if 	
			 	similarity > 0.5 &&
			  	document.content!=doc.content &&
			  	!@reject.include?(document.content) &&
			  	!@reject.include?(doc.content)

					@reject << document.content
			end
		end
	end

	@reject
end

# d = Date.today; p = get_todays_saved_story_objects(options = {:date => d});t = p['express'].map(&:title);get_uniqish_titles(t)