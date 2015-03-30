PERL	= perl
BDF2PSF	= $(PERL) ./bdftopsf.pl +u
BDF2PCF	= bdftopcf

pcf: status-18.pcf
psf: status-18.psf
all: psf pcf

DESTDIR	=
psfdir	= /usr/share/consolefonts
x11dir	= /usr/share/fonts/status

install: install-psf install-pcf fontdir

uninstall: uninstall-pcf uninstall-psf fontdir

fontdir:
	mkfontscale $(DESTDIR)$(x11dir)
	mkfontdir $(DESTDIR)$(x11dir)
	fc-cache -f $(DESTDIR)$(x11dir)

status-18.psf: status-18.bdf
	$(BDF2PSF) -o $@ $<

install-psf: psf
	mkdir -p $(DESTDIR)$(psfdir)
	gzip -c status-18.psf > $(DESTDIR)$(psfdir)/status-18.psf.gz

uninstall-psf:
	do rm -f $(DESTDIR)$(psfdir)/status-18.psf.gz

status-18.pcf: status-18.bdf
	$(BDF2PCF) -o $@ $<

install-pcf: pcf
	mkdir -p $(DESTDIR)$(x11dir)
	gzip -c status-18.pcf > $(DESTDIR)$(x11dir)/status-18.pcf.gz

uninstall-pcf:
	rm -f $(DESTDIR)$(x11dir)/status-18.pcf.gz

clean:
	rm -f *.psf *.pcf
