program rugzak
    ! ! hoe lang ongeveer max? some bash to make your eyes bleed 
    ! $ for line in $( cat ../data/input_d3.txt) ; do echo $line | wc -c ; done > temp
    ! $ cat temp | sort | tail -1
    ! $ rm temp
    ! max len is 49
    character(50)          :: line
    character(25)          :: comp_1, comp_2
    character(20)          :: filepath="../data/input_d3.txt"  ! da ga in ene keer! 
    integer                :: hl, ascidupl, val
    character(1)           :: duplicate
    integer                :: tot_priority
    tot_priority = 0

    open(1, file=filepath, status='old', action="read")
    do
        read(1, *, end=1) line
        hl = len(trim(line))/2      ! trim gets rid of unnecessary initialized space
        line = trim(line)
        comp_1 = line(:hl)      ! comp_i still has a bunch of trailing shit that needs to be trimmed when using it!
        comp_2 = line(hl+1:2*hl)
        ! print * , line
        do i = 1, hl
            idx = index(trim(comp_1), comp_2(i:i))
            if (idx .NE. 0) then
                ! print *, i, idx
                duplicate = comp_2(i:i)
                ascidupl = iachar(duplicate)

                if (ascidupl > 96) then
                    val = ascidupl - 96 ! 96 = - 97 + 1 
                else
                    val = ascidupl - 38 ! 38 = - 65 (asci) + 27 (priority A)
                end if
                tot_priority = tot_priority + val
                exit
                
            end if
        end do
    end do
1   close(1)    
    ! print *, " "
    ! print *, comp_1, comp_2, line
    ! print *, len(trim(comp_1)), len(trim(comp_2)), len(trim(line))
    ! print *, duplicate
    ! print *, ascidupl
    ! print *, val
    print *, "Total priority: ", tot_priority ! 10622 too high
end program rugzak