module ApplicationHelper
  def thisPage
    return controller.action_name
  end
  def title
    base_title = "Mirage Medicinal"
    if @title.nil?
      base_title
    else 
      "#{@title} :: #{base_title}"
    end
  end
  def metatag
    base_desc = ""
    if @metatag.nil?
      base_desc
    else 
      "#{@metatag}"
    end
  end
  def bodyclass
    base_class = "page"
    if @bodyclass.nil?
      base_class
    else 
      "#{@bodyclass}"
    end
  end
  def truncate_more(s, h, opts = {})
    opts = {:words => 12}.merge(opts)
    if opts[:sentences]
      return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
    end
    a = s.split(/\s/) # or /[ ]+/ to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? '&hellip; <a href="'+h+'" class="more">read more &raquo;</a>' : '')
  end
  def truncate_words(s, opts = {})
    opts = {:words => 12}.merge(opts)
    if opts[:sentences]
      return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
    end
    a = s.split(/\s/) # or /[ ]+/ to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? '&hellip;' : '')
  end
  
  def content(name, tag)
    @content = Content.find_by_name(name)
    if @content.blank?
      if user_signed_in?
        if current_user.admin?
          "<a href='#{new_content_path}'>Add</a>".html_safe
        end
      end
    else
      @header = "#{tag} #{@content.title}"
      render "layouts/content"
    end
  end
end
