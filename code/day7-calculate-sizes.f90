
program sizes
    implicit none
    character(58)               :: elfroot
    character(100)              :: folder
    integer                     :: file_size
    integer                     :: tot_size
    character(120)              :: ls_command
    character(20)               :: file_name
    
    elfroot = "/Users/nelereyniers/code_other/aoc22/helper-files/elfroot"
    tot_size = 0

    ! list the files in the directory (not the directories fors now )
    folder = elfroot
    ls_command = "ls -p "//trim(folder)//" | grep -v / > tmp_ls.txt"
    call system( ls_command )

    ! loop over the files in the directory
    open(1, file="tmp_ls.txt" )
    do
        ! read the next filename
        read(1, *, end=10) file_name
        ! open that file and extract its size (= its only content)
        open(99, file=trim(folder)//"/"//file_name)
        read(99, *, end=11) file_size
        ! add size to totall
    11  tot_size = tot_size + file_size
        print *, file_name, file_size
      close(99)
    end do
10  close(1)

    print *, tot_size

end program sizes