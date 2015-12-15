.PHONY: coffee clean

default: coffee

coffee:
	coffee -c javascripts/*.coffee

clean:
	rm -f javascripts/*.js
