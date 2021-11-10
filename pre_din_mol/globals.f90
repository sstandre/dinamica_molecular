module globals
  implicit none

  real(8), allocatable :: r(:,:), v(:,:), f(:,:)
  real(8) :: L, Vtot, T, rc2, Vrc, sigma, eps, m, dt, Ecin
  integer :: N, nstep, seed, nwrite

end module globals
