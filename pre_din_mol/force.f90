subroutine force(mode)
  use globals
  implicit none
  integer, intent(in) :: mode
  integer :: i, j
  real(8) :: dvec(3), fij(3)
  real(8) :: dist2, temp

  select case(mode)
  case(0)
    
    rc2 = (2.5*sigma)**2
    temp = sigma**6/rc2**3
    Vrc = 4*eps*temp*(temp-1)
    print *, "potencial de corte", Vrc

  case(1)
    
    Vtot = 0.0
    f(:,:) = 0.0

    do i = 1, N
      do j = i+1, N
        dvec = r(:,i) - r(:,j)
        dvec = dvec - L*int(2*dvec/L)
        dist2 = sum(dvec*dvec)
        if(dist2 < rc2) then
          temp = sigma**6/dist2**3
          Vtot = Vtot + 4*eps*temp*(temp-1) - Vrc
          fij=  24*eps*temp*(2*temp-1)/dist2 * dvec
          f(:,i) = f(:,i) + fij
          f(:,j) = f(:,j) - fij
        end if
      end do
    end do
  
  end select

end subroutine