program main
  use globals
  use ziggurat
  implicit none
  integer :: i, istep
  real(8) :: dte
  
  ! Inicializo posiciones y velocidades y calculo el potencial y las fuerzas
  call init()
  call force(1)

  ! print *, "posiciones"
  ! do i=1, N
  !   print *, r(:,i)
  ! end do

  print *, "Energia potencial inicial:", Vtot
  
  ! Hacemos unos pasos de minimizacion de energia, para evitar tener particulas muy cerca
  dte = 0.01
  do i=1,200
    r = r + f * (dte**2/(2*m))
    r = modulo(r, L)
    call force(1)
  end do

  print *, '**************************************************************************'
  ! Calculo inicial de energia
  Ecin = sum(v*v)/(2*m)
  print *, "energia"
  print *, "  potencial                 cinetica                  total"
  print *, Vtot, Ecin, Vtot+Ecin
  print *, '--------------------------------------------------------------------------'

  open(unit=15,file='output.dat',status='unknown')
  write(15, *) "Paso    Potencial   Cinetica    Total"
  do istep = 1, nstep
    ! Las nuevas posiciones y velocidades se calculan mediante Verlet
    call verlet()

    if(mod(istep,nwrite)==0) then
      Ecin = sum(v*v)/(2*m)
      print *, Vtot, Ecin, Vtot+Ecin
      write(15, *) istep, Vtot, Ecin, Vtot+Ecin
      call write_conf(1)
    end if
  end do
  print *, '**************************************************************************'
  close(15)

  ! print *, "posiciones"
  ! do i=1, N
  !   print *, r(:,i)
  ! end do

  ! Rutina de finalizacion para cerrar archivos, etc
   call final()

end program main
