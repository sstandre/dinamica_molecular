subroutine lang
    use globals
    use ziggurat
    implicit none

    real(8) :: Fr
    integer :: i, j
    
    do i=1,N
        do j=1,3
            Fr = rnor()*sqrt(2*gamma*m*T/dt)
            f(j,i) = f(j,i) - gamma*v(j,i) + Fr
        end do
    end do

end subroutine