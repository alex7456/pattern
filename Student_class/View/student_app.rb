require 'fox16'
require_relative './DataStructure/Adapter'
require_relative './DataStructure/student_list_adapter_DB'
require_relative './Database/connection'
require_relative './Filter/Filter'
require_relative './Filter/sort_by_fullname_filter'
require_relative './Controllers/student_list_controllers'
include Fox

class StudentApp < FXMainWindow
  attr_reader :items_per_page, :page_label, :table
  attr_accessor :current_page
  def initialize(app, db_config)
    super(app, "Список студентов", width: 1200, height: 700)
    @controller = StudentListController.new(self, db_config)

    @current_page = 1
    @items_per_page = 20

    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL)

    tab1 = FXTabItem.new(tab_book, "Список студентов")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL)

    filter_frame = FXVerticalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH, padding: 10)

    git_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X, padding: 5)
    FXLabel.new(git_filter_frame, "Наличие гита:", opts: JUSTIFY_LEFT | LAYOUT_FILL_X)
    @git_choice = FXComboBox.new(git_filter_frame, 3, nil, 0, COMBOBOX_STATIC | LAYOUT_FILL_X)
    @git_choice.appendItem("Да")
    @git_choice.appendItem("Нет")
    @git_choice.appendItem("Не важно")
    FXLabel.new(git_filter_frame, "Поиск по гиту:", opts: JUSTIFY_LEFT | LAYOUT_FILL_X)
    @git_search_field = FXTextField.new(git_filter_frame, 40, opts: LAYOUT_FILL_X) # Увеличиваем до 40 символов


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
    @email_search_field = FXTextField.new(email_filter_frame, 40, opts: LAYOUT_FILL_X)
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
    @phone_search_field = FXTextField.new(phone_filter_frame, 40, opts: LAYOUT_FILL_X)
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
    @telegram_search_field = FXTextField.new(telegram_filter_frame, 40, opts: LAYOUT_FILL_X)
    @telegram_search_field.enabled = true

    @telegram_choice.connect(SEL_COMMAND) do
      @telegram_search_field.enabled = @telegram_choice.currentItem == 0
      @telegram_search_field.text = "" unless @telegram_search_field.enabled
    end

    #table
    # Убеждаемся, что table_frame привязан к tab1_frame
    table_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL, width: 1000, height: 400)

    @table = FXTable.new(table_frame, nil, 0,
                         TABLE_COL_SIZABLE | TABLE_ROW_SIZABLE |
                           TABLE_NO_COLSELECT | TABLE_NO_ROWSELECT |
                           LAYOUT_FILL)

    @table.setTableSize(1, 4)  # 1 строка для заголовков, 4 столбца

    column_names = ["ID", "ФИО", "Контакт", "Github"]
    column_names.each_with_index do |name, index|
      @table.setColumnText(index, name)  # Устанавливаем заголовок
      @table.setColumnWidth(index, 120)  # Ширина столбцов
    end

    @table.setTableStyle(TABLE_COL_SIZABLE | TABLE_ROW_SIZABLE)  # Настройка таблицы
    @table.setBackColor(FXRGB(255, 255, 255)) # Белый фон

    @table.update  # Обновление UI





    #pages
    pagination_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    prev_button = FXButton.new(pagination_frame, "Предыдущая")
    @page_label = FXLabel.new(pagination_frame, "Страница: 1/1", nil, JUSTIFY_CENTER_X)
    next_button = FXButton.new(pagination_frame, "Следующая")
    prev_button.connect(SEL_COMMAND) { change_page(-1) }
    next_button.connect(SEL_COMMAND) { change_page(1) }
    #control buttons
    control_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH, padding: 10)
    add_button = FXButton.new(control_frame, "Добавить", opts: BUTTON_NORMAL, width: 100, height: 40)
    edit_button = FXButton.new(control_frame, "Изменить", opts: BUTTON_NORMAL, width: 100, height: 40)
    delete_button = FXButton.new(control_frame, "Удалить", opts: BUTTON_NORMAL, width: 100, height: 40)
    update_button = FXButton.new(control_frame, "Обновить", opts: BUTTON_NORMAL, width: 100, height: 40)

    edit_button.enabled = false
    delete_button.enabled = false
    update_button.connect(SEL_COMMAND) do
      @controller.refresh_data
    end

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

    @controller.refresh_data
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def set_table_params(column_names, whole_entities_count)
    @table.clearItems
    @table.setTableSize(1, column_names.size)  # 1 строка для заголовков

    column_names.each_with_index do |name, index|
      puts "DEBUG: Устанавливаем заголовок #{index} = #{name}"
      @table.setColumnText(index, name)
    end

    # Устанавливаем ширину столбцов
    set_column_widths

    @table.setTableStyle(TABLE_COL_SIZABLE | TABLE_ROW_SIZABLE | TABLE_READONLY) # Включаем заголовки и изменяемый размер
    @table.update  # Принудительное обновление UI
  end


  def set_column_widths
    @table.setColumnWidth(0, 100)  # ID
    @table.setColumnWidth(1, 300) # ФИО
    @table.setColumnWidth(2, 200) # Контакт
    @table.setColumnWidth(3, 300) # Github
  end






  def set_table_data(data_table)
    offset = (@current_page - 1) * @items_per_page  # Вычисляем смещение ID
    @table.setTableSize(data_table.row_count, data_table.column_count)

    (0...data_table.row_count).each do |row_index|
      (0...data_table.column_count).each do |col_index|
        value = data_table.get_element(row_index, col_index)

        # Если это первый столбец (ID), добавляем offset
        value = (row_index + 1 + offset).to_s if col_index == 0

        value = value.nil? ? "—" : value.to_s
        @table.setItemText(row_index, col_index, value)
      end
    end

    set_column_widths  # Устанавливаем ширину столбцов после данных

    @table.update
  end



  private

  def update_pagination(current_page, total_pages)
    @controller.update_pagination(current_page, total_pages)
  end

  def change_page(direction)
    @controller.change_page(direction)
  end


end
