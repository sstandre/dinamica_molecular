subroutine lang
    use globals
    use ziggurat
    implicit none

    real(8) :: Fr(3)
    integer :: i, j
    
    do i=1,N
        do j=1,3
            Fr(j) = rnor()*sqrt(2*gamma*m*T/dt)
        end do
        f(:,i) = f(:,i) - gamma*v(:,i) + Fr(:)
    end do

end subroutine