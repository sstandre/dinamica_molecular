MAKEFILE = Makefile
exe = simple
fcomp = gfortran #ifort # /opt/intel/compiler70/ia32/bin/ifc  
# Warning: the debugger doesn't get along with the optimization options
# So: not use -O3 WITH -g option
flags =  -O3  
# Remote compilation
OBJS = simple.o ziggurat.o 

.SUFFIXES:            # this deletes the default suffixes 
.SUFFIXES: .f90 .o    # this defines the extensions I want 

.f90.o:  
	$(fcomp) -c $(flags) $< 
        

$(exe):  $(OBJS) Makefile 
	$(fcomp) $(flags) -o $(exe) $(OBJS) 


clean:
	rm ./*.o ./*.mod	

ziggurat.o: ziggurat.f90
simple.o: ziggurat.o simple.f90
