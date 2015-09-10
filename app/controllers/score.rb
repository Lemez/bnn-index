SerenityPadrino::Serenity.controllers :score do
  
  require 'rugged'
  require 'linguist'



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

    get :getdata, :map => '/data' do

        stories = Story.all.pluck(:title,:source,:date,:mixed).uniq{|t|t[0]}.sort{|a,b|a[-1] <=> b[-1]}
        @story_neg = stories[0..9]
        @story_pos = stories[-10..-1].reverse
        # p @story_neg
        # p @story_pos
        # @story_pos = stories.order(:mixed)[0..9]

       

        all_scores = Score.all

        @scores = sort_and_deliver_scores(all_scores)

        @bad_stories = get_worst_by_paper
        @good_stories = get_best_by_paper


        @bad_stories.each do |s|
            p [s.source,s.mixed,s.title]
        end

        @good_stories.each do |s|
            p [s.source,s.mixed,s.title]
        end   

        repo = Rugged::Repository.new('.')
        project = Linguist::Repository.new(repo, repo.head.target_id)
        @project = formatforD3(project.languages).to_json.html_safe 
        @total = project.languages.values.inject(:+)

      render 'getdata'

    end
end

def get_worst_by_paper
   return [Story.mail.order(:mixed).first,
  Story.express.order(:mixed).first,
  Story.guardian.order(:mixed).first,
 Story.times.order(:mixed).first,
  Story.independent.order(:mixed).first,
  Story.telegraph.order(:mixed).first].sort{|a,b| a.mixed <=> b.mixed}
end

def get_best_by_paper
  return [Story.mail.order(:mixed).last,
  Story.express.order(:mixed).last,
  Story.guardian.order(:mixed).last,
  Story.times.order(:mixed).last,
  Story.independent.order(:mixed).last,
  Story.telegraph.order(:mixed).last].sort{|a,b| a.mixed <=> b.mixed}.reverse
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
