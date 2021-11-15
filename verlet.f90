subroutine verlet
    use globals
    implicit none

    ! Actualizo posiciones a t+dt
    r = r + v*dt +f*(dt**2/(2*m))
    ! Condiciones de contorno periodicas para la posicion
    r = modulo(r, L)
    ! Velocidad "intermedia" (en t+dt/2)
    v = v + f * (dt/(2*m))
    ! Actualizo el potencial y las fuerzas a t+dt
    call force(1)
    ! Velocidad "final" (en t+dt)
    v = v + f *(dt/(2*m))

end subroutine