program signal_processing
    implicit none
    character(20)               :: filename = "../data/input_d6.txt"
    character(4096)             :: elfsignal
    integer                     :: get_start_marker

    open(1, file=filename, status="old", action="read")
    read(1, "(A)") elfsignal
    ! elfsignal = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
    close(1)

    print *, "start-of-packet: ", get_start_marker(elfsignal, 4)
    print *, "start-of-message: ", get_start_marker(elfsignal, 14)

end program signal_processing


function get_start_marker(elfsignal, l) result(marker)
    integer, intent (in)           :: l 
    character(4096), intent(in)    :: elfsignal
    character(:), allocatable      :: fragment
    integer                        :: i, f, imax
    logical                        :: found
    integer                        :: marker
 
    imax = len(elfsignal)-l+1
    do i=1, imax
        fragment = elfsignal(i:i+l-1)
        do f=1, l-1             ! if no duplicates found before the last one, the last one must be unique: l-1
            found =  index(fragment, fragment(f:f), .false.) == index(fragment, fragment(f:f), .true.)
           
            if (.not. found) then
                exit
            end if
        end do

        if (found) then
            exit
        end if
    end do
    marker = i + l - 1
end function