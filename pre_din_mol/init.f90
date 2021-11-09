subroutine init()
  use globals
  use ziggurat
  implicit none

  logical :: es, ms
  integer :: i, j

![NO TOCAR] Inicializa generador de número random
  inquire(file='seed.dat',exist=es)
  if(es) then
      open(unit=10,file='seed.dat',status='old')
      read(10,*) seed
      close(10)
      ! print *,"  * Leyendo semilla de archivo seed.dat"
  else
      seed = 24583490
  end if

  call zigset(seed)
![FIN NO TOCAR]    

!   Leer variables del archivo input.dat y alocar variables
  open(unit=11,file='input.dat',action='read',status='old')
  read(11,*) 
  read(11,*) N, L, T, dt, nstep
  close(11)

  allocate(r(3,N),v(3,N),f(3,N))

! Chequear si existe matriz.dat, y cargarla como configuracion inicial
  inquire(file='configuracion.dat',exist=ms)
  if(ms) then
      print *,"  * Leyendo configuracion inicial de configuracion.dat"
      open(unit=12,file='configuracion.dat',status='old')
      do, j=1,N
        read(12,*) ( r(i,j), i=1,3 ) , ( v(i,j), i=1,3 )
      end do
      close(12)

  else
  ! Si no hay configuracion inicial, inicializar con 1 y -1 aleatorios
      print *,"  * Inicializando configuracion aleatoria"
      do i = 1, 3
          do j = 1, N
            r(i,j) = uni()*L
          end do
      end do

  end if

  ! Velocidades iniciales? gausiana con sigma**2=kT/m

  call write_conf(0)
  call force(0)

 end subroutine

