program badges
    ! ! hoe lang ongeveer max? some bash to make your eyes bleed 
    ! $ for line in $( cat ../data/input_d3.txt) ; do echo $line | wc -c ; done > temp
    ! $ cat temp | sort | tail -1
    ! $ rm temp
    ! max len is 49
    character(50)          :: elf1, elf2, elf3, both12
    character(1)           :: badge
    character(20)          :: filepath="../data/input_d3.txt"  ! da ga in ene keer! 
    integer                :: l, d, ascibadge, val, tot_priority
    tot_priority = 0

    open(1, file=filepath, status='old', action="read")
    do  
        print *, ""
        print *, "trio:"
        read(1, *, end=1) elf1
        read(1, *, end=1) elf2
        read(1, *, end=1) elf3
        print *, elf1, elf2, elf3

        ! find common item types between elf1 and elf2
        l = len(trim(elf1))
        d = 0
        do i = 1, l
            idx = index(trim(elf2), elf1(i:i))
            if (idx .NE. 0) then
                d = d+1
                both12(d:d) = elf1(i:i)
            end if
        end do
        
        ! find common item types between [elf1 I elf2] and elf3
        do i = 1, d
            idx = index(trim(elf3), both12(i:i))
            if (idx .NE. 0) then
                badge = both12(i:i)
                exit
            end if
        end do

        print *, badge
        ascibadge = iachar(badge)

        ! get the priority
        if (ascibadge > 96) then
            val = ascibadge - 96 ! 96 = - 97 + 1 
        else
            val = ascibadge - 38 ! 38 = - 65 (asci) + 27 (priority A)
        end if
        tot_priority = tot_priority + val
    end do
1   close(1)    
    ! print *, " "
    ! print *, comp_1, comp_2, line
    ! print *, len(trim(comp_1)), len(trim(comp_2)), len(trim(line))
    ! print *, duplicate
    ! print *, ascidupl
    ! print *, val
    print *, "Total priority: ", tot_priority ! 10622 too high
end program badges