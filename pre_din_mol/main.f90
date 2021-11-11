program main
  use globals
  use ziggurat
  implicit none
  integer :: i, istep
  
  ! Inicializo posiciones y velocidades y calculo el potencial y las fuerzas
  call init()
  call force(1)

  ! print *, "posiciones"
  ! do i=1, N
  !   print *, r(:,i)
  ! end do

  print *, "velocidad cuadratica media", sum(v*v)/(N)
  
  ! Hacemos unos pasos de minimizacion de energia, para evitar tener particulas muy cerca
  do i=1,10
    r = r + f * (dt**2/(2*m))
    r = modulo(r, L)
    call force(1)
  end do

  ! Calculo inicial de energia
  Ecin = sum(v*v)/(2*m)
  print *, "energia"
  print *, "  potencial                 cinetica                  total"
  print *, Vtot, Ecin, Vtot+Ecin

  print *, '*****************************************************************'
  do istep = 1, nstep
    ! Las nuevas posiciones y velocidades se calculan mediante Verlet
    call verlet()

    if(mod(istep,nwrite)==0) then
      Ecin = sum(v*v)/(2*m)
      print *, Vtot, Ecin, Vtot+Ecin
      call write_conf(1)
    end if
  end do
  print *, '*****************************************************************'
  
  ! print *, "posiciones"
  ! do i=1, N
  !   print *, r(:,i)
  ! end do

  ! Rutina de finalizacion para cerrar archivos, etc
   call final()

end program main
