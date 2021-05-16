module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print "Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "
      verb = gets.chomp
      break if verb == "q"

      action = nil

      if verb == "GET"
        print "Choose action (index/show) / q to exit: "
        action = gets.chomp
        break if action == "q"
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
	extend Resource
	def initialize
		@posts = []
	end

	def index    # показывает все посты 
		i = 0
		@posts.each{ |post|
			puts "#{i}: #{post}"
		}
	end

	def show      # показывает пост по определённому идентификатору
		puts "Введите идентификатор поста:"
		id = gets.to_i
		if id < 0 || id >= @posts.length
			puts "Неверно введен идентификатор."
		else
			puts "#{id}: #{@posts[id]}"
		end
	end

	def create     # добавление нового поста
		puts "Введите новый пост:"
		new_post = gets.chomp
		@posts << new_post
		puts "#{@posts.length - 1}: #{@posts[@posts.length - 1]}"
	end

	def update    # обновление поста
		puts "Введите идентификатор поста, который хотите обновить:"
		id = gets.to_i
		if id < 0 || id >= @posts.length
			puts "Неверно введен идентификатор."
		else
			puts "Введите новый текст поста:"
			new_post = gets.chomp
			@posts[id] = new_post
			puts "#{id}: #{@posts[id]}"
		end
	end

	def destroy     # удаление поста по идентификатору
		puts "Введите идентификатор поста, который хотите удалить:"
		id = gets.to_i
		if id < 0 || id >= @posts.length
			puts "Неверно введен идентификатор."
		else
			@posts.delete_at(id)
		end
	end
end


class CommentsController
	extend Resource
	def initialize
		@comments = []
	end

	def index    # показывает все комментарии
		i = 0
		@comments.each{ |comment|
			puts "#{i}: #{comment}"
		}
	end

	def show      # показывает комментарий по определённому идентификатору
		puts "Введите идентификатор комментария:"
		id = gets.to_i
		if id < 0 || id >= @comments.length
			puts "Неверно введен идентификатор."
		else
			puts "#{id}: #{@comments[id]}"
		end
	end

	def create     # добавление нового комментария
		puts "Введите новый комментарий:"
		new_comment = gets.chomp
		@comments << new_comment
		puts "#{@comments.length - 1}: #{@comments[@comments.length - 1]}"
	end

	def update    # обновление комментария
		puts "Введите идентификатор комментария, который хотите обновить:"
		id = gets.to_i
		if id < 0 || id >= @comments.length
			puts "Неверно введен идентификатор."
		else
			puts "Введите новый текст комментария:"
			new_comment = gets.chomp
			@comments[id] = new_comment
			puts "#{id}: #{@comments[id]}"
		end
	end

	def destroy     # удаление комментария по идентификатору
		puts "Введите идентификатор комментария, который хотите удалить:"
		id = gets.to_i 
		if id < 0 || id >= @comments.length
			puts "Неверно введен идентификатор."
		else
			@comments.delete_at(id)
		end
	end
end


class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, "posts")
	resources(CommentsController, "comments")


    loop do
      print "Введите ресурс, с которым хотите работать: (1 - Posts, 2 - Comments, q - Exit):" 
      choise = gets.chomp

      PostsController.connection(@routes["posts"]) if choise == "1"
      CommentsController.connection(@routes["comments"]) if choise == "2"
      break if choise == 'q'
    end

    puts "Good bye!"
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      "GET" => {
        "index" => controller.method(:index),
        "show" => controller.method(:show)
      },
      "POST" => controller.method(:create),
      "PUT" => controller.method(:update),
      "DELETE" => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
