* Create data
clear
set obs 10
g var1 = 1
g var2 = 2
g var3 = 3

/* Make a change in the do file ...*/



* See how Stata parses text by default
cap program drop learnparsing
program define learnparsing
	dis "0: `0'"
	dis "1: `1'"
	dis "2: `2'"
	dis "3: `3'"

end


learnparsing var1

learnparsing var1 var2 var3


* Create program
cap program drop learnsyntax
program define learnsyntax

	syntax varlist [if] [, OPTion]

	*dis "0: `0'"

	dis as txt "varlist: `varlist'"
	dis as txt "if: `if'"
	dis as txt "option: `option'"

end

* Run different specifications to see how locals change
learnsyntax var1

learnsyntax var1, option

learnsyntax var1 var2, option

learnsyntax var1 var2 if var3 == 3

learnsyntax var1 var2 if var3 == 3, opt


* what if we add a variable type & limit, default option, and use a /?
cap program drop learnsyntax
program define learnsyntax

	syntax varlist(numeric max = 2) [if/] [, OPTion(integer 1)]

	dis as txt "varlist: `varlist'"
	dis as txt "if: `if'"
	dis as txt "option: `option'"

end

* Run different specifications to see how locals change
learnsyntax var1

learnsyntax var1 if var2 == 2

learnsyntax var1, option(2)

learnsyntax var1, opt(2)

learnsyntax var1 var2 var3, option(2) == 103

learnsyntax var1 var2, option(string)

g var4 = "string"
learnsyntax var4

*---------------------------------------
* "practice" command
*---------------------------------------

	cap program drop practice
	program define practice

		syntax varlist(max=2), [Detail]
		
		*di "`2' `varlist'"
		
		*sum `1' `2' `detail'
			// This parsing includes the "," as part of the `2'
		
		sum `varlist', `detail'
			// This parsing is cleaner. Varlist doesnot include ","
		
	end

		practice var1 var2
		practice var1 var2, d
	
*---------------------------------------	
* "radsumit" command
*---------------------------------------

	cap program drop radsumit
	program define radsumit

		syntax varlist(max=3), [red]
		
		if "`red'"!=""{
			local color "in red"
		}
			
		di `color' 	_s(10) 	"Juan" _n  ///
					_s(10)	"`varlist'" _n ///
					_s(10)	"Anything else that you want!" 
		
	end

		radsumit var1 var2 var3
		radsumit var1 var2 var3, red

/*************************************************************************
/*************************************************************************




























