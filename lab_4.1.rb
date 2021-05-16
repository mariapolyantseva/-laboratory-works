class CashMachine
	def initialize
		if File.exists?("balance.txt")
			file = File.open("balance.txt")
			@balance = file.read
			file.close
		else 
			file = File.open("balance.txt", "w")
			file.puts(100.0)
			file.close
			file = File.open("balance.txt")
			@balance = file.read
			file.close
		end
	end
	def init
	loop{	
	print "Введите D, если хотите внести деньги. W, если хотите вывести. 
	B, если хотите проверить баланс и Q, если хотите выйти. \n"
	action = gets.chomp
	case action
		when "D", "d"
			puts "Ваш баланс: #{@balance}"
			print "Введите сумму депозита: "
			deposit = gets.to_f
			if deposit>0
				@balance = deposit + @balance.to_f
				file = File.open("balance.txt", "w")
				file.puts(@balance)
				file.close
			else puts "Вы ввели неверную сумму."
			end
		when "W", "w"
			puts "Ваш баланс: #{@balance}"
			print "Введите сумму, которую хотите снять: "
			withdraw = gets.to_f
			if withdraw <= @balance.to_f
				@balance = @balance.to_f - withdraw
				file = File.open("balance.txt", "w")
				file.puts(@balance)
				file.close
			else puts "Вы ввели неверную сумму."
			end
		when "B", "b" then puts "Ваш баланс: #{@balance}"
		when "Q", "q" then break 
		else puts "Вы ввели неверный символ."
	end
	}
	end		
end
cash_machine = CashMachine.new
cash_machine.init
