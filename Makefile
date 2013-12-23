all:	package

helloworld:	helloworld.o
	gcc -o helloworld helloworld.o

.c.o:	
	gcc -m64 -c $<

clean:
	rm -f helloworld *.o
	rm -rf output packaging

PACKAGE_VERSION=0:1.0-1
package:	helloworld
	mkdir -p output packaging
	cp -R skel/DEBIAN packaging
	mv packaging/DEBIAN/control.in packaging/DEBIAN/control
	perl -pi -e 's/\@\@VERSION\@\@/$(PACKAGE_VERSION)/' packaging/DEBIAN/control
	mkdir -p packaging/usr/bin
	cp helloworld packaging/usr/bin/
	fakeroot dpkg -b packaging output/helloworld-$(PACKAGE_VERSION).deb
