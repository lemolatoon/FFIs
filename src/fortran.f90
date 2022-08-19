module fortran_module
    contains
    subroutine f_is_prime(n, flag)
        implicit none
        integer(4), intent(in) :: n 
        logical, intent(out) :: flag
        integer(4) :: i
        if (n == 2) then
            flag = .true.
            return
        end if

        if (mod(n, 2) == 0) then
            flag = .false.
            return
        end if 
        i = 3
        do , while (i * i .le. n)
            if (mod(n, i) == 0) then
                flag = .false.
                return
            end if
            i = i + 2
        end do
        flag = .true.
        return
    end subroutine
    function f_n_th_prime(n) bind(c)
        use iso_c_binding
        implicit none
        integer(c_int), intent(in), value :: n
        integer(c_int) :: f_n_th_prime
        integer(8) :: count
        integer(4) :: current_n
        logical :: flag
        count = 1
        current_n = 2
        do, while (.true.)
            call f_is_prime(current_n, flag)
            if (flag) then
                if (count .eq. n) then
                    f_n_th_prime = current_n
                    return
                end if
                count = count + 1
            end if
            current_n = current_n + 1
        end do
    end function
    subroutine hello_fortran() bind(c, name="hello_fortran")
        Use iso_c_binding
        implicit none
        real pi
        type(c_funptr) func_ptr
        character(8) name
        interface
            subroutine hello_rust() bind(c)
            end subroutine
        end interface
        interface
            subroutine check_elapsed_time(func_ptr, name) bind(C)
                Use iso_c_binding
                type(c_funptr), value :: func_ptr ! pass by value
                character name(*)
            end subroutine
        end interface
        print *, "Hello from Fortran"
        func_ptr = c_funloc(f_n_th_prime) ! get function pointer
        name = "fortran"//c_null_char
        call check_elapsed_time(func_ptr, name)
        call hello_rust()
        print *, "Exiting Fortran..."
    end subroutine
end module