# coding: utf-8
class String
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

  def to_print
    self.gsub("\t", '').gsub("\n", '').gsub("\r", '')
  end

  def bstrip
    self.lstrip.rstrip
  end

  def to_widgets_array
    self.split(",").collect{|e| e.gsub("widget_",'').to_i}
  end

  def add_slash
    self == "" ? "" : (self.ends_with?("/") ? self : "#{self}/")
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
    # initial = Russian::translit(self.name).gsub(/[^A-Za-z0-9\s\-]/, "")[0,40].strip.gsub(/\s+/, "-").downcase
  end

  def to_search
    self == "" ? "" : self.sanitize_to_sphinx.split_stars
  end

  def remove_stars
    self.blank? ? "" : self.gsub('*', '')
  end

  def generate_secret_code(len = 7)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a - ['o', 'O', 'i', 'I']
    return Array.new(len) { chars[rand(chars.size)] }.join
  end
  alias_method :generate_password, :generate_secret_code

  def sanitize_to_sphinx
    self == "" ? "" : Unicode.downcase(self).gsub(/[^a-zа-яёЁ0-9\*]/, ' ').split("[")[0].split(" ").compact.join(" ")
  end

  def split_stars
    self == "" ? "" : self.split(" ").collect {|w| "*#{w}*" if w.size > 2}.join(" ")
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

  def to_page_slug
    self.gsub(/^\//, '').gsub(".html", "")
  end

  def valide_of_email?
    self =~ /(^$)|(^[a-z0-9]+([_\.-][a-z0-9]+)*@([a-z0-9]+([\.-][a-z0-9]+)*)+\.[a-z]{2,}$)/
  end

  def is_valid_email?
    !(self =~ CustomEmailValidator.email_regex).nil?
  end

  def is_valid_phone?
    !(self =~ CustomPhoneValidator.world_phone_regex).nil?
  end

  def is_valid_phone_from_sng?
    !(self =~ CustomPhoneValidator.sng_phone_regex).nil?
  end

  def is_valid_phone_from_russia?
    !(self =~ CustomPhoneValidator.russian_phone_regex).nil?
  end

  def is_valid_phone_from_ukrain?
    !(self =~ CustomPhoneValidator.ukrainian_phone_regex).nil?
  end

  def normalize_phone
    self == "" ? "" : self.gsub(/\D+/,'')
  end

  def to_clean
    allowed_tags = {
      :elements => %w[p a ul ol li u],
      :attributes => {'a' => ['href', 'title']},
      :protocols => {'a' => {'href' => ['http', 'https', 'mailto']}}
    }
    self == "" ? "" : Sanitize.clean(self, allowed_tags)
  end
  
  def encode_from_1251_to_utf8
    self.force_encoding("windows-1251").encode("utf-8", :invalid => :replace)
  end

  def encode_to_utf8
    self.encode("utf-8", :invalid => :replace)
  end
end
