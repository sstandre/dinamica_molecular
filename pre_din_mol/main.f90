program main
  use globals
  use ziggurat
  implicit none
  integer :: i, istep
  
  call init()

  print *, "posiciones"

  do i=1, N
    print *, r(:,i)
  end do

  call force(1)
  print *, "energia potencial total", Vtot

  print *, "fuerzas"

  do i=1, N
    print *, f(:,i)
  end do

  ! Hacemos un paso de minimizacion de energia, para evitar tener particulas muy cerca
  r = r + f * (dt**2/(2*m))
  r = modulo(r, L)
  call force(1)

  do istep = 1, nstep
    call verlet()

    if(mod(istep,nwrite)==0) then
      print *, "energia potencial total", Vtot
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
  
  
  
  ! loop de minimizacion: minimizo energia sin usar las velocidades
  ! Loop de MD posta

  

  ! checklist
  ! -calculo bien V
  ! -calculo bien F
  ! -esta bien verlet
  ! - se conserva la energia
  

  ! Loop de MD posta
! ! do istep=1,Nsteps
!   call verlet_posit
!   force(:,:)=
!   call force()
!   call verlet_veloc()
!   todas las dinamicas actualizadas
!   call mide() E = suma cinetacica + potencial
!   call write_E_t -> istep *dt = tiempo


   call final()

end program main
