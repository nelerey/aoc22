program calories
    ! wc -l input_d1.txt: 2240
    integer, dimension(1200) :: elfs
    integer                  :: felf ! my favourite elf because they're carrying the most snacks. thanks boo 
    character(len=20)        :: cal_line
    integer                  :: cal
    integer                  :: j ! elf ID
    logical                  :: is_sorted
    integer                  :: tmp
    elfs = 0 ! sets all elements of array to zero instead of random vals
    
    open(unit=1, file="../data/input_d1.txt", status='old', action="read")
    
    ! Loop through the file. If we find a blank line, move on to the next elf; if the line is not blank, add calories to current elf.
    j = 0
    do i = 1,2240
        read(1, '(A)') cal_line
     !   print *, cal_line
        if (cal_line.EQ.' ') then
            j = j + 1
            ! print *, "blank!"
           ! print *, j
        else
            read (cal_line, *) cal
            elfs(j) = elfs(j) + cal
            ! print *, cal
        end if 
    end do
    close(1)

    ! what do you mean there's no sorted() function
    is_sorted = .false.
    ! please don't make me use a while loop i'm scared
    do while (.NOT. is_sorted)
        is_sorted = .true.
        do i = 1,1199 
            if (elfs(i) < elfs(i+1)) then ! sort descending: switch if first is smaller than second
                tmp = elfs(i)
                elfs(i) = elfs(i+1)
                elfs(i+1) = tmp
                is_sorted = .false.
            end if
        end do
    end do

    !print *, elfs
    !print *, ""

    felf = maxval(elfs)
    print *, "Calories carried by favourite elf: ",  felf
    print *, "Calories carried by my 3 favourite elves", sum(elfs(1:3))

end program calories

! gfortran day1.f90 -o day1.o
! ./day1.o