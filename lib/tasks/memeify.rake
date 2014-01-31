require 'meme_generator'

desc "Memeify"
task :memeify do
  if ENV['captions'].blank? || ENV['image_dir'].blank?
    puts "Error: Missing paramaters."
    puts "Ex: rake memeify captions=lib/captions/captions.txt image_dir=lib/images"
    exit
  end
  puts "Memeifying...."
  MemeGenerator.new(ENV['captions'], ENV['image_dir']).memeify
end