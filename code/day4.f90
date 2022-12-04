! let the record state that I keep using the .f90 extension but I have no idea which fortran version I'm actually working with
! alsook, logical to integer conversion bestaat niet en/of is niet altijd betrouwbaar ofzo?!
! tijd om eens te leren hoe functies en subroutines werken eh nele vinde ook nie da had gisteren eigenlijk wel nuttig geweest eh nele

program cleaningAssignments
    character(20)   :: filepath="../data/input_d4.txt"
    character(20)    :: line
    integer         :: elf1(1000, 2), elf2(1000, 2), contained(1000) !, !elf1in2(1000), elf2in1(1000)
    logical, dimension(1000) :: elf1in2_1, elf1in2_2, elf2in1_1, elf2in1_2, elf1in2, elf2in1


    open(1, file=filepath, status='old', action="read")
    ! store all pair starts and pair ends in vectors
    do i=1,1000
        read(1,'(A)', end=1) line ! elf1(i,:), elf2(i,:)
        ! making integers
        read(line( : index(line, "-")-1), "(i2.1)")                      elf1(i, 1)
        read(line(index(line, "-")+1 : index(line, ",")-1), "(i2.1)")    elf1(i, 2)
        read(line(index(line, ",")+1 : index(line, "-", back=.true.)-1), "(i2.1)") elf2(i, 1)
        read(line(index(line, "-", back=.true.)+1 : ), "(i2.1)")         elf2(i, 2)

    end do
1   close(1)

    ! print *, line( : index(line, "-")-1)
    ! print *, line(index(line, "-")+1 : index(line, ",")-1)
    ! print *, line(index(line, ",")+1 : index(line, "-", back=.true.)-1)
    ! print *, line(index(line, "-", back=.true.)+1 : )

    ! print *, elf1
    ! print *, elf2
    
    elf1in2 = (elf1(:,1) >= elf2(:,1)) .and. (elf1(:,2) <= elf2(:,2))
    elf2in1 = (elf2(:,1) >= elf1(:,1)) .and. (elf2(:,2) <= elf1(:,2))
    
    where (elf1in2 .or. elf2in1)
        contained = 1
    elsewhere
        contained = 0
    end where

    print *, sum(contained)

end program cleaningAssignments

