cd ../../
make uninstall
make install

cd tests/2dboxper/
rm -rf vtk/
rm -rf obj/
rm nekcem
./setup maxwell 2dboxper
make
#./nekcem