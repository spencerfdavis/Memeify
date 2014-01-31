class MemeGenerator
  include Magick
  include ActionView::Helpers::TextHelper

  attr_accessor :captions_file, :image_dir

  MEME_DIRECTORY = "lib/memes"

  def initialize(captions_file, image_dir)
    @captions_file = captions_file
    @image_dir = image_dir
  end

  def memeify
    images = Dir.glob("#{image_dir}/*.jpg").shuffle
    captions = File.readlines(captions_file)

    images.each do |image|
      img = ImageList.new(image)
      img.resize_to_fill!(600)
      text = Draw.new
      text.gravity = Magick::SouthGravity
      text.pointsize = 25
      text.font = 'Helvetica-Bold'
      caption = word_wrap(captions.sample, line_width: 50)

      img.annotate(text, 0,0,2,28, caption) { text.fill = "#000000" } # Drop Shadow
      img.annotate(text, 0,0,0,30, caption) { text.fill = "#ffffff" } # Main Text
      img.write("#{MEME_DIRECTORY}/memeify_#{SecureRandom.uuid}.jpg")
    end
  end
end