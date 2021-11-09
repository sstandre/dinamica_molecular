program simple
  use ziggurat
  implicit none
  real(8) :: a,b,c,d,e
  character(len=50) :: text

  open(unit=11,file='input.dat',action='read',status='old')
  read(11,*) a, text
  read(11,*) b, text
  read(11,*) c, text
  read(11,*) d, text
  read(11,*) e, text
  close(11)

  print *, a
  print *, b
  print *, c
  print *, d
  print *, e

end program simple
