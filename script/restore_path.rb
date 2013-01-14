# encoding: utf-8
# ruby -ne 'puts  $_.chomp if $_ =~ /\.\.\/images/; gsub(/\.\.\/images/, "/assets/images") ' ../app/assets/stylesheets/*.css
# ruby -ne 'puts  $_.chomp if $_ =~ /\.\.\/images/; gsub(/\.\.\/images/, "/assets/images") ' ../app/assets/stylesheets/*.scss

# js
files = Dir.glob(File.dirname(__FILE__)+"/../app/assets/javascripts/**/*.js")
#files += Dir.glob( File.dirname(__FILE__)+"/../app/assets/stylesheets/*.css")
files.each do |f_name|
  puts f_name
  File.open(f_name, "r+") do |f|
    out = ""
    f.each do |line| 
      if line =~ /url\(images/
        puts line
        out << line.gsub(/\(images/, "(/assets")
      elsif line =~ /url\(\'images/
        puts line
        out << line.gsub(/\(\'images/, "\(\'/assets")
      else
        out << line
      end
    end
    f.pos = 0
    f.print out
    f.truncate(f.pos)
  end
end

# css
files = Dir.glob(File.dirname(__FILE__)+"/../app/assets/stylesheets/**/*.*css")
#files += Dir.glob( File.dirname(__FILE__)+"/../app/assets/stylesheets/*.css")
files.each do |f_name|
  puts f_name
  File.open(f_name, "r+") do |f|
    out = ""
    f.each do |line| 
      puts line if line =~ /\.\.\/images/
      out << line.gsub(/\.\.\/images/, "/assets")
    end
    f.pos = 0
    f.print out
    f.truncate(f.pos)
  end
end

# erb
files = Dir.glob( File.dirname(__FILE__)+"/../app/views/**/*.erb")
files.each do |f_name|
  puts f_name
  File.open(f_name, "r+") do |f|
    out = ""
    f.each do |line| 
      puts line if line =~ /\"images\//
      out << line.gsub(/\"images\//, "\"/assets/")
    end
    f.pos = 0
    f.print out
    f.truncate(f.pos)
  end
end

