# encoding: UTF-8
class JuventudePlugin::PeopleJob < JuventudePlugin::ReportJob

  ETNIA = { 1 => 'Pardo', 2 => 'Preto', 3 => 'Branco', 4 => 'Indígena', 5 => 'Amarelo'}
  ORIENTACAO_SEXUAL = { 1 => 'Homosexual', 2 => 'Heterosexual', 3 => 'Bisexual', 4 => 'Assexual'}
  GENERO = { 1 => 'Masculino', 2 => 'Feminino' }

  def perform
    profile = Profile.find(profile_id)
    report_folder = JuventudePlugin::ReportJob.create_report_path(profile, report_path)
    create_people_report(profile, report_folder)
  end

  def create_people_report(profile, report_folder)
    people = Person.all
    filepath = "/tmp/#{report_path}/people.csv"
    CSV.open(filepath, 'w', {:col_sep => ';', :force_quotes => true} ) do |csv|
      csv << ['Identificador','Criado em','Nome', 'Email', 'Orientação Sexual', 'Identidade de Gênero', 'Transgenero', 'Raça', 'Estado', 'Cidade']
      count = 0
      people.map do |person|
        count += 1
        puts "%s de %s: adicionando pessoa: %s" % [count, people.count, person.id ]
        info = []
        info.push(person.identifier)
        info.push(person.created_at.strftime("%d/%m/%y %H:%M"))
        info.push(person.name)
        info.push(person.email)
        info.push(ORIENTACAO_SEXUAL[person.orientacao_sexual.to_i])
        info.push(GENERO[person.identidade_genero.to_i])
        info.push(person.transgenero)
        info.push(ETNIA[person.etnia.to_i])
        info.push(person.city)
        info.push(person.state)
        csv << info
      end
    end
    upload_file(compress_files('people', 'people.csv'), profile, report_folder)
  end

end
