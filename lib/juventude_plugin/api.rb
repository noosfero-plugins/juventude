class JuventudePlugin::API < Grape::API

  resource :states do

    get do
      states = State.select([:id, :name]).order(:name)
      present states
    end

    get ':id' do
      state = State.select([:id, :name]).find(params[:id])
      present state
    end

    get ':id/cities' do
      state = State.find(params[:id])
      cities = City.where(:parent_id => state.id).select([:id, :name]).order(:name)
      present cities
    end

    get ':id/cities/:city_id' do
      city = City.select([:id, :name]).find(params[:city_id])
      present city
    end

  end
end
