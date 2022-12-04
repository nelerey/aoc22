program cleaningAssignments
    character(20)   :: filepath="../data/input_d4.txt"
    character(20)    :: line
    integer         :: elf1(1000, 2), elf2(1000, 2), contained(1000), overlapping(1000)
    logical, dimension(1000) :: elf1in2, elf2in1
    logical, dimension(1000) :: elf1lap2,  elf2lap1

    ! read data
    open(1, file=filepath, status='old', action="read")
    do i=1,1000
        read(1,'(A)', end=1) line ! elf1(i,:), elf2(i,:)
        ! making integers
        read(line( : index(line, "-")-1), "(i2.1)")                      elf1(i, 1)
        read(line(index(line, "-")+1 : index(line, ",")-1), "(i2.1)")    elf1(i, 2)
        read(line(index(line, ",")+1 : index(line, "-", back=.true.)-1), "(i2.1)") elf2(i, 1)
        read(line(index(line, "-", back=.true.)+1 : ), "(i2.1)")         elf2(i, 2)

    end do
1   close(1)
    
    ! part 1
    elf1in2 = (elf1(:,1) >= elf2(:,1)) .and. (elf1(:,2) <= elf2(:,2))
    elf2in1 = (elf2(:,1) >= elf1(:,1)) .and. (elf2(:,2) <= elf1(:,2))
    where (elf1in2 .or. elf2in1)
        contained = 1
    elsewhere
        contained = 0
    end where
    print *, "n contained: ", sum(contained)

    ! part 2
    elf1lap2 = ((elf1(:,1) >= elf2(:,1)) .and. (elf1(:,1) <= elf2(:,2)))   ! start of elf 1 in the range of elf 2
    elf2lap1 = ((elf2(:,1) >= elf1(:,1)) .and. (elf2(:,1) <= elf1(:,2)))   ! start of elf 2 in the range of elf 1

    where (elf1lap2 .or. elf2lap1)
        overlapping = 1
    elsewhere
        overlapping = 0
    end where
    print *, "n overlapping: ", sum(overlapping)

end program cleaningAssignments
! deze cleaning assignments hadden properder gekund.