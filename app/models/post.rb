class Post < ActiveRecord::Base
   has_many :comments
   belongs_to :user
   belongs_to :topic
   mount_uploader :image, ImageUploader

   default_scope { order('created_at DESC') }

   validates :title, length: { minimum: 5 }, presence: true
   validates :body, length: { minimum: 20 }, presence: true
   validates :topic, presence: true
   validates :user, presence: true

   def markdown_title
      render_as_markdown title
   end

   def markdown_body
     render_as_markdown body
   end

   private

   def render_as_markdown(markdown)
       renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions)
      (redcarpet.render markdown).html_safe
   end

 end


 # most of your code should be in your models rather in the controller
 # look up fat models, skinny controller
 # models are wrappers around the database; container for details about the data  (eg. you just want markdown within the Post model) => called "encapsulation"