require 'open3'

# класс содержащий методы работы с приложением
class Utils

  # отправка клиенту информационного сообщения
  def send_info(client)
    client.puts "Welcome to server"
    client.puts "You can enter commands: run <app>[argument...] | close <app>"
  end

  # добавление приложения в хеш
  def add_to_hash(app, app_hash, client)
    pid, stdout = Open3.capture2("pgrep #{app}")

    app_hash.store(app,pid)

    if pid.to_s.empty?
      client.puts "Warning! The application was unable to start correctly"
    end
    client.puts "#{app} is running"
  end

  # метод для запуска приложения
  def run(app, app_hash, argument, client)
    client.puts "Starting #{app}"

    if argument.to_s.empty?
      system("#{app} &")
      add_to_hash(app, app_hash, client)
    else
      system("#{app} #{argument} &")
      add_to_hash(app, app_hash, client)
    end
  end

  def close(app, app_hash, client)

    client.puts "Closing #{app}"
    system("kill #{app_hash[app]}")
    stdout = Open3.capture2("pgrep #{app}")

    if stdout.to_s.empty?
      client.puts "App not find in running apps hash. Please check app status "
    elsif app_hash.key?(app)
      app_hash.delete(app)
      client.puts "#{app} successfully close"
    else
      client.puts "App not find in running apps hash. Please check app status "
    end
  end
end


