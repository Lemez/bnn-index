SerenityPadrino::Serenity.controllers :score do
  
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

    stories = Story.all.order(:mixed)
    @story_neg = stories.first
    @story_pos = stories.reverse.first

    @scores_unsorted=Score.all

    @allscores, @tmp = [],[]
    @previous = @scores_unsorted[-1]

    @scores_unsorted.each_with_index do |s,i|
      if i==0
        @tmp << s
      elsif s.date==@previous.date
        @tmp << s
      else
        @allscores << @tmp
        @tmp = [s]
      end
      @previous=s
    end

    
    @scores=[]
    @allscores.each do |date_array|
      o={}

      sources = date_array.map(&:source)
      scores = date_array.map(&:score)

      sources.each_with_index do |d,i|
        o['date']=date_array[0].date.strftime("%X-%d/%m/%Y")
        o[sources[i].downcase]=scores[i]
        o['average'] = (scores.inject(0.0) { |sum, el| sum + el } / scores.size).round(2)

      end
      @scores << o
    end
    @scores = @scores.to_json.html_safe

    render 'getdata'
  end
  

end
