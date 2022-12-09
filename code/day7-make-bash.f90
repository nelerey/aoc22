!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! step I. make a folder for dumping the exact file system of the elves into
! step II. modify the commands as follows:
!   1. remove all the '$ '
!   2. replace 'cd /' by 'cd <elfroot>' 
!   3. replace ls and its outcomes by:
!        a. for files: <filesize> > <filename>
!        b. for directories: if they don't exist, mkdir
!   4. replace cd <anything but .. or /> by: if the directory doesn't exist, mkdir, then cd directory
! step III. run the bash script
! step IV. profit
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program bash_n_prog
    implicit none
    character(25)               :: inputpath = "../testdata/testin_d7.txt"   ! (20)
    character(10)                :: outscript = "bash_d7.sh"
    character(70)                :: command
    character(70)                :: item
    character(57)               :: elfroot
    integer                     :: delim_idx
    character(35)               :: filesize
    elfroot = "/Users/nelereyniers/code_other/aoc22/helper-files/elfroot"

    open(1, file=inputpath, status="old")
    open(2, file=outscript, status='new')

    do
        read(1, "(A)", end=1) command
        ! remove the $ :
    10  if (index(command, "$ ") .ne. 0) then
            command = command(3:)
        end if

        ! replace commands
        ! replace root with elfroot
        if (index(command, "cd /") .ne. 0) then
            write(2, *) "cd ", elfroot
        ! replace ls by making directories and writing file sizes to files
        else if (index(command, "ls ") .ne. 0) then
            do 
                read(1, "(A)", end=1) item
                ! check if it's an item or a command
                if (index(item, "$ ") .ne. 0) then
                    goto 10
                else
                    ! if the item is a directory, make directory if it doesn't yet exist. 
                    ! luckily bash will just proceed after an error so we can just do it with mkdir.
                    if (index(item, "dir") .ne. 0) then
                        write(2, *) "mkdir ", item(5:)
                    ! if the item is a file, write its size into a file with that name
                    else 
                        delim_idx = index(item, " ")
                        write(2, *) "echo ", item(:delim_idx-1), " > ", item(delim_idx+1:) 
                    end if
                end if
            end do
        
        ! keep cd ..
        else if ( index(command, "cd ..").ne.0 ) then
            write(2,*) command
        
        ! replace other cd by mkdir <directory> and then cd into it
        else if ( index(command, "cd ").ne.0 ) then
            write(2,*) "mkdir ", command(4:)
            write(2,*) "cd ", command(4:)
        end if 

    end do
1   close(1)
    
end program bash_n_prog
