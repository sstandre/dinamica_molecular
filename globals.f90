module globals
  implicit none

  real(8), allocatable :: r(:,:), v(:,:), f(:,:)
  real(8) :: L, Vtot, T, rc2, Vrc, sigma, eps, m, dt, Ecin, gamma, presion, bines(0:200)
  integer :: N, nstep, seed, nwrite, cuentas(200)
  logical :: vb

end module globals
