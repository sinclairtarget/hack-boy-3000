.PHONY: sassy_coffee clean

default: sassy_coffee

sassy_coffee:
	coffee -cmo public javascripts/*.coffee
	sass --update stylesheets:public
	cp vendor/*.js public

clean:
	rm -f public/*.js public/*.map public/*.css
