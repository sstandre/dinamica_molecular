subroutine verlet
    use globals
    implicit none

    r = r + v*dt +f*(dt**2/(2*m))
    r = modulo(r, L)
    v = v + f * (dt/(2*m))
    call force(1)
    v = v + f *(dt/(2*m))

end subroutine