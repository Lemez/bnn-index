SerenityPadrino::Serenity.controllers :score do
  
  # require 'rugged'
  # require 'linguist' # sacking off as charlock holmes dependency doesnt work with heroku
  require 'json'

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/' do
  #   'Hello world!'
  # end

    layout :data
    get :index, :map => '/' do

      # chart
      p "getting scores"
        @scores = sort_and_deliver_scores(Score.all).to_json.html_safe
        # @bad_stories = get_worst_by_paper.uniq{|a|a.title.downcase}
        # @good_stories = get_best_by_paper.uniq{|a|a.title.downcase}
        # @bad_stories.each {|s|p s.title}
        # @good_stories.each {|s|p s.title} 

      #info
      # p "formatting for D3"
        # repo = Rugged::Repository.new('.')
        # project = Linguist::Repository.new(repo, repo.head.target_id)
        # @projectd3 = formatforD3(project.languages)
        # @projectjson = @projectd3.to_json
        # @project = @projectjson.html_safe 
        # @total = project.languages.values.inject(:+)

      # hardcoding project lines as charlock holmes dependency isn't working

      @project = [{"lang"=>"JavaScript","amount"=>56.39},{"lang"=>"HTML","amount"=>21.18},{"lang"=>"Ruby","amount"=>14.54},{"lang"=>"CSS","amount"=>6.07}].to_json.html_safe
      @total = 261690

      # today's stories
      p "setting up sentiment analysers"
        set_up_sentiment_analysers 
        p "getting RSS"       
        data = get_todays_rss
        p "DONE RSS" 
        @todays_data, @todays_stories = data[0], data[1].to_json.html_safe

        @time,@date = @todays_data[0].split("-")
        p "DONE todays stories"

      # awards
      p "getting awards"

        stories = Story.all.pluck(:title,:source,:date,:mixed)
          .uniq{|t|t[0].downcase}
          .select{|a| !a[-1].nan?} #using Float.nan? to remove all quirks with floats
          .sort{|a,b|a[-1] <=> b[-1]}
        @story_neg = stories[0..9]
        @story_pos = stories[-10..-1].reverse
      p "DONE awards"

        render 'index'

    end
end

def get_worst_by_paper
   return [Story.mail.order(:mixed).first,
          Story.express.order(:mixed).first,
          Story.guardian.order(:mixed).first,
          Story.times.order(:mixed).first,
          Story.independent.order(:mixed).first,
          Story.telegraph.order(:mixed).first]
                        .sort{|a,b| a.mixed <=> b.mixed}
end

def get_best_by_paper
  return [Story.mail.order(:mixed).last,
        Story.express.order(:mixed).last,
        Story.guardian.order(:mixed).last,
        Story.times.order(:mixed).last,
        Story.independent.order(:mixed).last,
        Story.telegraph.order(:mixed).last]
                      .sort{|a,b| a.mixed <=> b.mixed}.reverse
end


def stories_to_date_hash
  h={}
  Story.all.each do |story|

     formatted_date = s.date.strftime("%x")

     if h.has_key?(formatted_date)

      array = h[formatted_date]
      array << {:title=>s.title,:source=>s.source, :score=>s.score}

     else

     end

   end
end

def get_worst_stories_each_day(records)

  results = []  
  records.map(&:date).each do |d|
    t1 = {}
  
    # story = Story.where(date).strftime("%x") == '?' ,d.strftime("%x")).order(:mixed).first
    # p story
    # t1['date']= d

    # t1['details']= {'title'=>story.title,'source'=>story.source,'score'=>story.mixed}
              
    # results << t1
  end
  # results
end
