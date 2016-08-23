namespace :jekyll do

  # desc 'Get team_members from API for a specific site id'
  # task :get_team, :site_id do |t, args|
  #   puts "Building team_members files from API"
  #   @team_members = HTTParty.get("http://localhost:3000/sites/#{args[:site_id]}/team_members/render_json")
  #   puts @team_members
  # end

  desc 'Create team file'
  task :team_file, :site_id do |t, args|
    puts "Getting the team members for Site ##{args[:site_id]}"
    @team_members = HTTParty.get("http://localhost:3000/sites/#{args[:site_id]}/team_members/render_json")
    puts "Writing team members to json data file"
    File.open('./themeA/_data/team.json',"w") do |f|
      f.write(@team_members.to_json)
    end
  end

  desc 'Create treatments file'
  task :treatments_file, :site_id do |t, args|
    puts "Getting the treatments for Site ##{args[:site_id]}"
    @treatments = HTTParty.get("http://localhost:3000/sites/#{args[:site_id]}/treatments/render_json")
    puts "Writing treatments to json data file"
    File.open('./themeA/_data/treatments.json',"w") do |f|
      f.write(@treatments.to_json)
    end
  end

  desc 'Create testimonials file'
  task :testimonials_file, :site_id do |t, args|
    puts "Getting the testimonials for Site ##{args[:site_id]}"
    @testimonials = HTTParty.get("http://localhost:3000/sites/#{args[:site_id]}/testimonials/render_json")
    puts "Writing testimonials to json data file"
    File.open('./themeA/_data/testimonials.json',"w") do |f|
      f.write(@testimonials.to_json)
    end
  end

  desc 'Create gallery file'
  task :gallery_file, :site_id do |t, args|
    puts "Getting the gallery pictures for Site ##{args[:site_id]}"
    @gallery_pictures = HTTParty.get("http://localhost:3000/sites/#{args[:site_id]}/gallery_pictures/render_json")
    puts "Writing gallery pictures to json data file"
    File.open('./themeA/_data/gallery.json',"w") do |f|
      f.write(@gallery_pictures.to_json)
    end
  end

  desc 'Build jekyll assets'
  task :build, :site_id do |t, args|
    puts "Building Jekyll after creating all /_data files"
    Rake::Task["jekyll:treatments_file"].invoke(args[:site_id])
    Rake::Task["jekyll:testimonials_file"].invoke(args[:site_id])
    Rake::Task["jekyll:gallery_file"].invoke(args[:site_id])
    Rake::Task["jekyll:team_file"].invoke(args[:site_id])
    sh "cd themeA && jekyll build --destination ../dentalsite2"
    sh "open dentalsite2/index.html"
  end

end
