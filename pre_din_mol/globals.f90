module globals
  implicit none

  real(8), allocatable :: r(:,:), v(:,:), f(:,:)
  real(8) :: L, Vtot, T, rc2, Vrc, sigma, eps, m, dt
  integer :: N, nstep, seed

end module globals
