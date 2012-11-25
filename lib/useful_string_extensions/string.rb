# coding: utf-8
String.class_eval do
  def string_from_file
    data = ''
    f = File.open(self, "r")
    f.each_line do |line|
      data += line
    end
    data
  end

  def replace_quotes
    self == "" ? "" : self.gsub("&quot;", '"')
  end

  def show?
    self.blank? ? "Не указано" : self
  end

  def detect_encoding
    CharDet.detect(text)['encoding'] rescue "utf-8"
  end

  def in_one_line
    self.gsub("\n",'').gsub("\r",'').gsub("\t",'')
  end

  def get_id_from_url
    self.split("-").last
  end

  def bstrip
    self.lstrip.rstrip
  end

  def to_widgets_array
    self.split(",").collect{|e| e.gsub("widget_",'').to_i}
  end

  def change_plus
    self.gsub("+7", "8")
  end

  def to_keywords
    self == '' ? '' : self.gsub(/\(\)\,\./, '').split(" ").collect {|e| Unicode.downcase(e)}.join(", ")
  end

  def to_simple_xhtml
    self == '' ? '' : self.gsub("<br>", '<br />')
  end

  def remove_extension
    File.basename(self, '.*')
  end

  def get_extension
    File.extname(self)
  end

  def remove_promo
    self.include?("::") ? self.split("::")[1] : self
  end

  def to_slug
    Russian.translit(self).downcase.gsub(/[^a-z0-9]+/, '-').strip.chomp('-')

    # другой вариант
    #initial = Russian::translit(self.name).gsub(/[^A-Za-z0-9\s\-]/, "")[0,40].strip.gsub(/\s+/, "-").downcase
  end

  def to_search
    self.blank? ? "" : self.sanitize_to_sphinx.split_stars
  end

  def remove_stars
    self.blank? ? "" : self.gsub('*', '')
  end

  def sanitize_to_sphinx
    Unicode.downcase(self).gsub(/[^a-zа-яёЁ0-9\*]/, ' ').split("[")[0].split(" ").compact.join(" ")#.strip
  end

	def split_stars
		self.sanitize_to_sphinx.split(" ").collect {|w| "*#{w}*" if w.size > 2}.join(" ")
	end

	def end_stars
		self.sanitize_to_sphinx.split(" ").collect {|w| "#{w}*" if w.size > 2}.join(" ")
	end

  def path_to_a
    self.gsub(",", '').split(' ').compact
  end

  def capitalize
    Unicode::capitalize(self)
  end

  def clearify
    self.blank? ? "" : self.gsub('"', "'")
  end

  def is_valid_email?
    !(self =~ CustomEmailValidator.email_regex).nil?
  end

  def to_page_slug
    self.gsub(/^\//, '').gsub(".html", "")
  end
end
