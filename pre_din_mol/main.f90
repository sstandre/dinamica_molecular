program main
  use globals
  use ziggurat
  implicit none
  integer :: i, istep
  
  ! Inicializo posiciones y velocidades y calculo el potencial y las fuerzas
  call init()
  call force(1)

  print *, "posiciones"
  do i=1, N
    print *, r(:,i)
  end do

  print *, "velocidades"
  do i=1, N
    print *, v(:,i)
  end do

  ! Hacemos un paso de minimizacion de energia, para evitar tener particulas muy cerca
  r = r + f * (dt**2/(2*m))
  r = modulo(r, L)
  call force(1)

  ! Calculo inicial de energia
  print *, "energia potencial", Vtot
  Ecin = sum(v*v)/(2*m)
  print *, "energia cinetica", Ecin
  print *, "energia total", Vtot+Ecin


  do istep = 1, nstep
    ! Las nuevas posiciones y velocidades se calculan mediante Verlet
    call verlet()

    if(mod(istep,nwrite)==0) then
      ! print *, "energia potencial", Vtot
      Ecin = sum(v*v)/(2*m)
      ! print *, "energia cinetica", Ecin
      print *, "energia total", Vtot+Ecin

      call write_conf(1)

    end if
  end do

  print *, "posiciones"
  do i=1, N
    print *, r(:,i)
  end do

  print *, "fuerzas"
  do i=1, N
    print *, f(:,i)
  end do

  ! Rutina de finalizacion para cerrar archivos, etc
   call final()

end program main
