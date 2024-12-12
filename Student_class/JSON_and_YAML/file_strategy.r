class FileStrategy
  def load(file_path)
    raise NotImplementedError, 'Метод load должен быть реализован в подклассе'
  end

  def save(file_path, students)
    raise NotImplementedError, 'Метод save должен быть реализован в подклассе'
  end
end
