PREFIX = /usr/local

web: web.sh web.awk web.tsv
	cat web.sh > $@
	echo 'exit 0' >> $@
	echo '#EOF' >> $@
	tar cz web.awk web.tsv >> $@
	chmod +x $@

test: web.sh
	shellcheck -s sh web.sh

clean:
	rm -f web

install: web
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f web $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/web

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/web

.PHONY: test clean install uninstall
