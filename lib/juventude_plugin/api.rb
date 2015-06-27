class JuventudePlugin::API < Grape::API

  resource :states do

    get do
      states = State.select([:id, :name])
      present states
    end

    get ':id/cities' do
      state = State.find(params[:id])
      cities = City.where(:parent_id => state.id).select([:id, :name])
      present cities
    end

  end
end
