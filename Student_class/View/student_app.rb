require 'fox16'
require_relative './DataStructure/Adapter'
require_relative './DataStructure/student_list_adapter_DB'
require_relative './Database/connection'
require_relative './Filter/Filter'
require_relative './Filter/sort_by_fullname_filter'
include Fox

class StudentApp < FXMainWindow
  def initialize(app, db_config)
    super(app, "Список студентов", width: 1200, height: 700)
    #db connect
    db_connection = Connection.instance(db_config)
    db_adapter = Students_list_db_adapter.new(db_connection)
    @list_adapter = Students_list_db_adapter.new(db_adapter)

    @current_page = 1
    @items_per_page = 20

    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL)

    tab1 = FXTabItem.new(tab_book, "Список студентов")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL)

    filter_frame = FXVerticalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)

    #git
    git_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(git_filter_frame, "Наличие гита:")
    @git_choice = FXComboBox.new(git_filter_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @git_choice.appendItem("Да")
    @git_choice.appendItem("Нет")
    @git_choice.appendItem("Не важно")
    @git_choice.numVisible = 3
    FXLabel.new(git_filter_frame, "Поиск по гиту:")
    @git_search_field = FXTextField.new(git_filter_frame, 25)
    @git_search_field.enabled = true

    @git_choice.connect(SEL_COMMAND) do
      @git_search_field.enabled = @git_choice.currentItem == 0
      @git_search_field.text = "" unless @git_search_field.enabled
    end

    #email
    email_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(email_filter_frame, "Наличие почты:")
    @email_choice = FXComboBox.new(email_filter_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @email_choice.appendItem("Да")
    @email_choice.appendItem("Нет")
    @email_choice.appendItem("Не важно")
    @email_choice.numVisible = 3
    FXLabel.new(email_filter_frame, "Поиск по почте:")
    @email_search_field = FXTextField.new(email_filter_frame, 25)
    @email_search_field.enabled = true

    @email_choice.connect(SEL_COMMAND) do
      @email_search_field.enabled = @email_choice.currentItem == 0
      @email_search_field.text = "" unless @email_search_field.enabled
    end

    #phone
    phone_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(phone_filter_frame, "Наличие телефона:")
    @phone_choice = FXComboBox.new(phone_filter_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @phone_choice.appendItem("Да")
    @phone_choice.appendItem("Нет")
    @phone_choice.appendItem("Не важно")
    @phone_choice.numVisible = 3
    FXLabel.new(phone_filter_frame, "Поиск по телефону:")
    @phone_search_field = FXTextField.new(phone_filter_frame, 25)
    @phone_search_field.enabled = true

    @phone_choice.connect(SEL_COMMAND) do
      @phone_search_field.enabled = @phone_choice.currentItem == 0
      @phone_search_field.text = "" unless @phone_search_field.enabled
    end

    #tg
    telegram_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(telegram_filter_frame, "Наличие Telegram:")
    @telegram_choice = FXComboBox.new(telegram_filter_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @telegram_choice.appendItem("Да")
    @telegram_choice.appendItem("Нет")
    @telegram_choice.appendItem("Не важно")
    @telegram_choice.numVisible = 3
    FXLabel.new(telegram_filter_frame, "Поиск по Telegram:")
    @telegram_search_field = FXTextField.new(telegram_filter_frame, 25)
    @telegram_search_field.enabled = true

    @telegram_choice.connect(SEL_COMMAND) do
      @telegram_search_field.enabled = @telegram_choice.currentItem == 0
      @telegram_search_field.text = "" unless @telegram_search_field.enabled
    end

    #table
    table_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL)
    @table = FXTable.new(table_frame, nil, 0, TABLE_COL_SIZABLE | LAYOUT_FILL | TABLE_READONLY | TABLE_NO_COLSELECT)
    setup_table

    #pages
    pagination_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    prev_button = FXButton.new(pagination_frame, "Предыдущая")
    @page_label = FXLabel.new(pagination_frame, "Страница: 1/1", nil, JUSTIFY_CENTER_X)
    next_button = FXButton.new(pagination_frame, "Следующая")
    prev_button.connect(SEL_COMMAND) { change_page(-1) }
    next_button.connect(SEL_COMMAND) { change_page(1) }
    #control buttons
    control_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    add_button = FXButton.new(control_frame, "Добавить")
    edit_button = FXButton.new(control_frame, "Изменить")
    delete_button = FXButton.new(control_frame, "Удалить")
    update_button = FXButton.new(control_frame, "Обновить")
    edit_button.enabled = false
    delete_button.enabled = false

    @table.connect(SEL_SELECTED) do
      selected_rows = (@table.selStartRow..@table.selEndRow).to_a
      selected_count = selected_rows.count { |row| @table.rowSelected?(row) }

      if selected_count == 0
        edit_button.enabled = false
        delete_button.enabled = false
      elsif selected_count == 1
        edit_button.enabled = true
        delete_button.enabled = true
      else
        edit_button.enabled = false
        delete_button.enabled = true
      end
    end

    @table.connect(SEL_DESELECTED) do
      edit_button.enabled = false
      delete_button.enabled = false
    end


    #tab2
    tab2 = FXTabItem.new(tab_book, "2")
    FXVerticalFrame.new(tab_book, LAYOUT_FILL).tap do |frame|
      FXLabel.new(frame, "2", nil, LAYOUT_CENTER_X)
    end
    #tab3
    tab3 = FXTabItem.new(tab_book, "3")
    FXVerticalFrame.new(tab_book, LAYOUT_FILL).tap do |frame|
      FXLabel.new(frame, "3", nil, LAYOUT_CENTER_X)
    end
    #closeapp
    quit_button = FXButton.new(self, "Закрыть окно", nil, nil, 0, FRAME_RAISED | LAYOUT_FILL_X)
    quit_button.connect(SEL_COMMAND) { getApp().exit }

    load_data
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  private

  def setup_table
    @table.setTableSize(0, 4)

    @table.setColumnWidth(0, 50)
    @table.setColumnWidth(1, 250)
    @table.setColumnWidth(2, 350)
    @table.setColumnWidth(3, 400)

  end

  def load_data
    total_items = @list_adapter.get_student_short_count(@filter)
    total_pages = (total_items.to_f / @items_per_page).ceil

    update_pagination_label(@current_page, total_pages)

    data_table = @list_adapter.get_k_n_student_short_list(@current_page, @items_per_page, @filter)

    # Проверяем, что data_table - это Data_table
    unless data_table.is_a?(Data_table)
      raise "Ошибка: get_k_n_student_short_list должен возвращать Data_table, но получен #{data_table.class}"
    end

    # Проверяем, есть ли данные
    return if data_table.nil? || data_table.row_count == 0

    # Устанавливаем размер таблицы
    @table.setTableSize(data_table.row_count, 4)

    # Заголовки столбцов
    column_names = ["ID", "ФИО", "Контакт", "Git"]
    column_names.each_with_index { |name, index| @table.setColumnText(index, name) }

    # Заполнение таблицы
    (0...data_table.row_count).each do |row_index|
      id = data_table.get_element(row_index, 0).to_s
      fullname = data_table.get_element(row_index, 1).to_s
      contact = data_table.get_element(row_index, 2).to_s
      git = data_table.get_element(row_index, 3).to_s

      @table.setItemText(row_index, 0, id)
      @table.setItemText(row_index, 1, fullname)
      @table.setItemText(row_index, 2, contact)
      @table.setItemText(row_index, 3, git.empty? ? "Нет данных" : git)
    end
    @table.setColumnWidth(0, 50)   # ID
    @table.setColumnWidth(1, 250)  # ФИО
    @table.setColumnWidth(2, 400)  # Контакт
    @table.setColumnWidth(3, 450)  # Git
  end


  def update_pagination_label(current_page, total_pages)
    @page_label.text = "Страница: #{current_page}/#{total_pages}"
  end

  def change_page(page)
    total_items = @list_adapter.get_student_short_count
    total_pages = (total_items.to_f / @items_per_page).ceil

    new_page = @current_page + page
    return if new_page < 1 || new_page > total_pages

    @current_page = new_page
    load_data
  end
end
