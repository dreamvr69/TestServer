require 'prawn'
class Pdf
  def self.generate_pdf()
    page_height = 600
    page_width = 900

    logo_height = 70
    logo_width = 250

    font_size_small = 16

    event_name = "BOSCH FAMILY DAY 2017"
    place = "CRYSTALL BALL ROOM"
    datetime = "20.07.2017 - 23.07.2017"

    top_margin_of_label = 10

    label_image = "./label.png"

    first_angle_image = "./img.png"
    second_angle_image = "./img.png"
    third_angle_image = "./img.png"

    first_additional_image = "./img.png"
    second_additional_image = "./img.png"
    third_additional_image = "./img.png"

    first_additional_service_image = "./img.png"
    second_additional_service_image = "./img.png"

    Prawn::Document.generate("hello.pdf", :background => "./back.jpg", :page_size => [page_height, page_width],
     :page_layout => :landscape, :margin=>[0,0,0,0]) do

    	font_families.update("Arial" => {
    	    :normal => "/home/maxim/Desktop/ServerRequests/truefont.ttf"
    	  })

    	font "Arial"

    	# 1 страница

    	width_of('1', :size => 2)


      	text event_name + "\n\n\n", :align => :center, :valign => :center, size: 36, color: "FFFFFF", kerning: true
    	move_down 40

    	text place, :align => :center, :valign => :center, color: "FFFFFF"
    	move_down 40

    	text datetime, :align => :center, :valign => :center, color: "FFFFFF"

    	#Картинка наверху каждой pdf\
    	#150 - половина ширины картинки, 15 - отступ от верха
    	logo_x = (bounds.right/2) - (logo_width/2)
    	logo_y = bounds.top - top_margin_of_label

    	image label_image, :width => logo_width, :height => logo_height, :at => [logo_x, logo_y]




    	start_new_page

    	#Картинка наверху каждой pdf\
    	#150 - половина ширины картинки, 20 - отступ от верха

    	# 2 страница



    	image first_angle_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

    	image "./label.png", :width => logo_width, :height => logo_height, :at => [logo_x, logo_y], :position=>:center

    	move_cursor_to logo_y - logo_height


    	text place, color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small
    	text "РАКУРС № 1", color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small

    	start_new_page

    	# 3 страница

    	image second_angle_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

    	image label_image, :width => logo_width, :height => logo_height, :at => [logo_x, logo_y]

    	move_cursor_to logo_y - logo_height


    	text place, color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small
    	text "РАКУРС № 2", color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small

    	start_new_page

    	# 4 страница

    	image third_angle_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

    	image label_image , :width => logo_width, :height => logo_height, :at => [logo_x, logo_y]

    	move_cursor_to logo_y - logo_height


    	text place, color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small
    	text "РАКУРС № 3", color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small

    	start_new_page

    	# 5 страница
    	if !first_additional_image.empty?

    		image label_image, :width => logo_width, :height => logo_height, :at => [logo_x, logo_y]

    		move_cursor_to logo_y - logo_height


    		text place + "                                                                  " + "ИНДИВИДУАЛЬНЫЙ РАКУРС № 1", color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small
    		move_down 5

    		image first_additional_image, :width => page_width * 0.8, :height => page_height * 0.8, :position => :center
    		start_new_page
    	end

    	# 6 страница

    	if !second_additional_image.empty?

    		image label_image, :width => logo_width, :height => logo_height, :at => [logo_x, logo_y]

    		move_cursor_to logo_y - logo_height


    		text place + "                                                                  " + "ИНДИВИДУАЛЬНЫЙ РАКУРС № 2", color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small
    		move_down 5

    		image second_additional_image, :width => page_width * 0.8, :height => page_height * 0.8, :position => :center
    		start_new_page
    	end
    	#7 страница

    	if !third_additional_image.empty?

    		image label_image, :width => logo_width, :height => logo_height, :at => [logo_x, logo_y]

    		move_cursor_to logo_y - logo_height


    		text place + "                                                                  " + "ИНДИВИДУАЛЬНЫЙ РАКУРС № 3", color: "FFFFFF", :align => :center, :valign => :top, size: font_size_small
    		move_down 5

    		image third_additional_image, :width => page_width * 0.8, :height => page_height * 0.8, :position => :center
    	end

    	start_new_page

    	background = "./img.jpg"

    	#8 страница

    	image first_additional_service_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

    	fill_color "000000"
    	transparent(0.6) do
    		fill_rectangle [bounds.right - 650, bounds.bottom + 150], 650, 150

    	end


    	fill_color "FFFFFF"
    	text_box "ВСЕГО ЗА 7 990 \u2713 без ндс", size: 30,  at: [bounds.right - 650, bounds.bottom + 140], align: :center, inline_format: true

    	fill_color "FFFFFF"
    	text_box "В ТЕЧЕНИЕ 12 ЧАСОВ ИНДИВИДУАЛЬНО ДЛЯ ВАС:", size: 17,  at: [bounds.right - 620, bounds.bottom + 80],  width: 300, leading: 5, align: :center
    	text_box "СДЕЛАЕМ ЭКСКЛЮЗИВНУЮ РАССАДКУ
    	РАССТАВИМ ЛЮБОЕ ОБОРУДОВАНИЕ
    	ДОБАВИМ ПЛАНИРУЕМЫЕ ДЕКОРАЦИИ
    	НАНЕСЕМ ТРЕБУЕМЫЙ БРЕНДИНГ", size: 12,  at: [bounds.right - 320, bounds.bottom + 100],  width: 300, align: :left, leading: 12

    	stroke_color "FFFFFF"
    	line [bounds.right - 335, bounds.bottom + 15], [bounds.right - 335, bounds.bottom + 105]
    	stroke


    	start_new_page

    	#9 страница

      image first_additional_service_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

    	fill_color "000000"
      transparent(0.6) do
    		fill_rectangle [bounds.left, bounds.bottom + 200], 500, 200

    	end


    	fill_color "FFFFFF"
    	text_box "ОТ 14 990 \u2713 без ндс", size: 30,  at: [bounds.left - 400, bounds.bottom + 195], align: :center, inline_format: true

    	fill_color "FFFFFF"
    	text_box "СДЕЛАЕМ ЭКСКЛЮЗИВНУЮ РАССАДКУ
      РАССТАВИМ ЛЮБОЕ ОБОРУДОВАНИЕ
      ДОБАВИМ ПЛАНИРУЕМЫЕ ДЕКОРАЦИИ
      НАНЕСЕМ ТРЕБУЕМЫЙ БРЕНДИНГ
      РАССТАВИМ ЖЕЛАЕМУЮ ФЛОРИСТИКУ
      ВОССОЗДАДИМ НАТУРАЛЬНОЕ ОСВЕЩЕНИЕ", size: 12,  at: [bounds.left + 10, bounds.bottom + 150],  width: 250, leading: 8, align: :left


    	text_box "РАССАДИМ ГОСТЕЙ ПО МЕСТАМ
      ДОБАВИМ ПОДВЕСНЫЕ КОНСТРУКЦИИ", size: 12,  at: [bounds.left + 270, bounds.bottom + 150],  width: 250, align: :left, leading: 8

    	stroke_color "FFFFFF"
    	line [bounds.left + 255, bounds.bottom + 25], [bounds.left + 255, bounds.bottom + 150]
    	stroke

    end
  end
end
