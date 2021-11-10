subroutine write_conf(mode)
    use globals
    implicit none
    integer, intent(in) :: mode
    integer :: i


    select case(mode)
    case(0)
        open(unit=20, file='movie.vtf', status='unknown')
        write(20, *) 'atom 0:',N-1, 'radius 0.5 name Ar'

    case(1)
        write(20, *) "timestep"
        write(20, *)
        do i=1,N
            write(20, *) r(:,i)
        end do

    case(2)
        close(20)

    end select

end subroutine