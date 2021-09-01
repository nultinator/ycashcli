

import Pkg
Pkg.add("JSON")
Pkg.add("OrderedCollections")
import JSON
using JSON
using OrderedCollections

pwd()
println("Enter the path to ycash/zcash-cli")
location = readline()
cd(location)
function ycashcli(command)
	JSON.parse(read(`./ycash-cli $command`, String))
end
addresses = JSON.parse(read(`./ycash-cli z_listaddresses`, String))
notes = JSON.parse(read(`./ycash-cli z_listunspent`, String))
memos = String(hex2bytes(notes[1]["memo"])) #FIX THE KEY VARIABLE IN THIS LINE!!!!!

function checky()
	yaddr_regex = r"^ys1\w{75}"

	from = readline()
           
	while match(yaddr_regex, from) == nothing
  	println("That yaddr looks invalid. Please enter a valid address")
  	from = readline()
end
	

#Sending works now!!!!!, Still need function to convert memo to hexadecimal format though
function z_send()
           println("Send from?")
           from = readline()
           println("Send to?")
           to = readline()
           println("How much?")
           amount = readline()
           println("Memo?")
           memo = readline()
           params = OrderedDict{String, Any}([("address", to), ("amount", amount)])
           sendparams = JSON.json(params)
           run(`./ycash-cli z_sendmany "$from" '['$sendparams']'`)
       end


