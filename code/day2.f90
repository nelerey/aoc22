program bladsteenschaar
    character(len=1)        :: opm ! opponent's move
    character(1)            :: mym ! my move
    character(20)           :: filepath
    integer                 :: score_s1, score_s2
    character(3)            :: myshapes, opshapes ! options for each
    integer                 :: idx_my, idx_op
    integer, dimension(3,3) :: shapevals_1, shapevals_2, winvals, roundvals_1, roundvals_2, outcomevals  ! init an array

    filepath="../data/input_d2.txt"
    ! rock paper scissors is:
    opshapes = "ABC"
    myshapes = "XYZ" 
    
    ! score for each combo. fortran arrays are column-major! 
    shapevals_1 = reshape((/ 1, 2, 3, 1, 2, 3, 1, 2, 3 /), shape=shape(shapevals_1))
    winvals = reshape((/ 3, 6, 0, 0, 3, 6, 6, 0, 3 /), shape=shape(winvals))
    roundvals_1 = shapevals_1 + winvals
    
    shapevals_2 = reshape((/ 3, 1, 2, 1, 2, 3, 2, 3, 1 /), shape=shape(shapevals_2))
    outcomevals = reshape((/ 0, 0, 0, 3, 3, 3, 6, 6, 6 /), shape=shape(outcomevals))
    roundvals_2 = outcomevals + shapevals_2
    print *, outcomevals
    print *, roundvals_2

    open(1, file=filepath, status='old', action="read")
    score_s1 = 0
    score_s2 = 0
    do
        read(1, *, end=1) opm, mym
        ! print *, mym, opm

        ! matrix indices for the combo
        idx_op = index(opshapes, opm)
        idx_my = index(myshapes, mym)
        ! score for the combo
        score_s1 = score_s1 + roundvals_1(idx_my, idx_op)  ! indexing is (rowid, colid)
        score_s2 = score_s2 + roundvals_2(idx_op, idx_my)
    end do
1   close(1)

print *, mym, opm
print *, idx_my, idx_op
print *, roundvals_2(idx_op, idx_my)
print *, "My strategy 1 score is ", score_s1
print *, "My strategy 2 score is ", score_s2

end program bladsteenschaar
! gfortran day2.f90 -o day2.o
! time(./day2.o)