program main
  use globals
  use ziggurat
  implicit none
  integer :: istep

  
  ! Inicializo posiciones y velocidades y calculo el potencial y las fuerzas
  call init()
  call force(1)

  ! print *, "posiciones"
  ! do i=1, N
  !   print *, r(:,i)
  ! end do

  if (vb) then
    print *, '**************************************************************************'
    ! Calculo inicial de energia
    Ecin = sum(v*v)/(2*m*N)
    Vtot = Vtot / N
    print *, "energia"
    print *, "  potencial                 cinetica                  total"
    print *, Vtot, Ecin, Vtot+Ecin
    print *, '--------------------------------------------------------------------------'
  end if

  open(unit=15,file='output.dat',status='unknown')
  write(15, *) "Paso    Potencial   Cinetica    Total     Presion"
  do istep = 1, nstep
    ! Las nuevas posiciones y velocidades se calculan mediante Verlet
    call verlet()

    if(mod(istep,nwrite)==0) then
      Ecin = sum(v*v)/(2*m*N)
      Vtot = Vtot / N
      if (vb) print *, Vtot, Ecin, Vtot+Ecin
      write(15, *) istep, Vtot, Ecin, Vtot+Ecin, presion
      call write_conf(1)
    end if
  end do
  if (vb) print *, '**************************************************************************'
  close(15)

  ! print *, "posiciones"
  ! do i=1, N
  !   print *, r(:,i)
  ! end do

  ! Rutina de finalizacion para cerrar archivos, etc
   call final()

end program main
