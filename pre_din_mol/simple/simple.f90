program simple
  use ziggurat
  implicit none
  real(8) :: rvec(3, 4)
  real(8) :: L
  integer :: i

  L = 10.0

  rvec(1,:) = (/8.5,3.2,-7.2,2.3/)
  rvec(2,:) = (/8.5,3.2,-7.2,6.7/)
  rvec(3,:) = (/8.5,3.2,-1.2,12.9/)
  do i=1,3
  print *, rvec(i,:)
  end do
  print *, ''
  rvec = modulo(rvec, L)
  do i=1,3
    print *, rvec(i,:)
  end do


end program simple
