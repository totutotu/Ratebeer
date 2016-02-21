class AddStyles < ActiveRecord::Migration
  def change
    Beer.all.each do |b|
      style = (Style.all.detect {|style| style.name == b.old_style})
      unless style.nil?
        b.style_id = style.id
        b.save
      end
    end
  end
end
