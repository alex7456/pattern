class StudentListController
  def initialize(view, db_config)
    @view = view
    @student_list = Students_list_db_adapter.new(Students_list_db_adapter.new(db_config))
    @data_list_student_short = Data_list_student_short.new([])
    @data_list_student_short.add_observer(@view)
  end

  def refresh_data
    total_items = @student_list.get_student_short_count
    total_pages = (total_items.to_f / @view.items_per_page).ceil

    student_data = @student_list.get_k_n_student_short_list(@view.current_page, @view.items_per_page)

    @data_list_student_short.data = student_data.data
    @data_list_student_short.selected = student_data.selected
    @data_list_student_short.count = total_items

    @data_list_student_short.notify

    update_pagination(@view.current_page, total_pages) # Обновляем `@page_label.text`
  end



  def update_pagination(current_page, total_pages)
    @view.page_label.text = "Страница: #{current_page}/#{total_pages}"
  end

  def change_page(page)
    total_items = @student_list.get_student_short_count
    total_pages = (total_items.to_f / @view.items_per_page).ceil

    new_page = @view.current_page + page
    return if new_page < 1 || new_page > total_pages

    @view.current_page = new_page
    refresh_data
    update_pagination(@view.current_page, total_pages) # Обновляем текст страницы
  end

end
