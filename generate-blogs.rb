# code copy and past from diaria project
# http://rubyforge.org/frs/?group_id=65&release_id=251
WORKINGDIR = ARGV[0]
p WORKINGDIR
def get_header
  header = ""
  File.open("#{WORKINGDIR}header.html","r") do | file |
    file.readlines.each do | line |
      header << line          
    end
  end
  header
end
def get_footer
  footer = ""
  File.open("#{WORKINGDIR}footer.html","r") do |file|
    file.readlines.each do | line |
      footer << line
    end
  end
  footer
end
def get_blog_posts
  puts "Using data from #{WORKINGDIR}"
  dir = Dir.open("#{WORKINGDIR}") 
  blog_posts = Array.new
  dir.each do |file|
    puts "adding #{file}"
    blog_posts.push file
  end
  blog_posts.sort!
end
def do_index
  index = File.new("#{WORKINGDIR}index.html","w")
  index.write get_header
  content = ''
  get_blog_posts.each do |post|
    link = "<li><a href=\"#{post}\">#{post}</a></li>\n"
    content << link
  end
  index.write content
  index.write get_footer
end
do_index
