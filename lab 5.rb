require 'socket'

server = TCPServer.new 2020

class CashMachine
	$balance = ""
	if File.exists?("balance.txt")
		file = File.open("balance.txt")
		$balance = file.read
		file.close
	else 
		file = File.open("balance.txt", "w")
		file.puts(100.0)
		file.close
		file = File.open("balance.txt")
		$balance = file.read
		file.close
	end
	$balance = $balance.to_f 

	def deposit(deposit1)
		if deposit1>0
			$balance += deposit1
		else "Вы ввели неверную сумму."
		end
	end
	def withdraw(withdraw1)
		if withdraw1 <= $balance.to_f
			$balance -= withdraw1
		else "Вы ввели неверную сумму."
		end
	end
	def balance
		"Balance: #{$balance}"
	end
end

while (connection = server.accept)
	cmachine = CashMachine.new

	request = connection.gets
	pathway, full_path = request.split(" ")
	path = full_path.split("/")[1]

	if full_path.split("/")[1].include?("?")
   		method = path.split("?")[0]
		value = path.split("?")[1].split("=")[1].to_f
	else method = full_path.split("/")[1]
 	end
		
	connection.print "HTTP/1.1 200\r\n"
  	connection.print "Content-Type: text/html\r\n"
  	connection.print "\r\n"

  	connection.print case method
        when "deposit" then cmachine.deposit(value)
        when "withdraw" then cmachine.withdraw(value)
        when "balance" then cmachine.balance
        else "Ошибка"
    end

    file = File.open("balance.txt", "w")
	file.puts($balance)
	file.close
 
	connection.close 
end			
