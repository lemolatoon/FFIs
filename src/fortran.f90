subroutine hello_fortran() bind(c)
! subroutine main() bind(c)
    implicit none
    real pi
    ! interface
    !     subroutine print_rsp() bind(c)
    !     end subroutine
    ! end interface
    interface
        subroutine hello_rust() bind(c)
        end subroutine
    end interface
    print *, "Hello from Fortran"
    pi = atan(1.0) * 4.0
    print *, "pi = ", pi, " from Fortran" 
    call hello_rust()
    print *, "Exiting Fortran..."
end subroutine