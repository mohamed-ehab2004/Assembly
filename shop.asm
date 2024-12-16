.MODEL large
.DATA
MENU_START DB 10,13,10,13, "*************  Shop  ************* $"
MENU1 DB 10,13, "1. Add T-shirt ( 200 LE for piece ) $"
MENU2 DB 10,13, "2. Add jacket ( 250 LE for piece ) $"
MENU3 DB 10,13, "3. Add jeans ( 300 LE for piece ) $"
MENU4 DB 10,13, "4. Show cart $"
MENU5 DB 10,13, "5. Exit $"
MENU_END DB 10,13, "********************************** $"
MSG_INPUT DB 10,13,10,13, "Enter your choice (1-5): $"
ADD_MSG DB 10,13, "  Added Successfully $"
MSG_N_TSHIRT DB 10,13, "Total t-shirts : $"
MSG_N_JACKET DB 10,13, "Total jacket : $"
MSG_N_JEANS DB 10,13, "Total jeans : $"
MSG_TOTAL_ITEMS DB 10,13, "Total items : $"
MSG_TOTAL_PRICE DB 10,13, "Total price : $"
CURRENCY DB " LE $"
WRONG_INPUT DB 10,13, "Invalid choice. Try again. $"
TSHIRT_COUNT DW 0
JACKET_COUNT DW 0
JEANS_COUNT DW 0
TOTAL_COUNT DW 0
TSHIRT_PRICE DW 0
JACKET_PRICE DW 0
JEANS_PRICE DW 0
TOTAL_PRICE DW 0

.CODE
MAIN PROC FAR
    .STARTUP
START:
    ; Display the menu
    LEA DX, MENU_START
    MOV AH, 09H
    INT 21H

    LEA DX, MENU1
    MOV AH, 09H
    INT 21H

    LEA DX, MENU2
    MOV AH, 09H
    INT 21H

    LEA DX, MENU3
    MOV AH, 09H
    INT 21H

    LEA DX, MENU4
    MOV AH, 09H
    INT 21H
    
    LEA DX, MENU5
    MOV AH, 09H
    INT 21H

    ; Display input message
    LEA DX, MSG_INPUT
    MOV AH, 09H
    INT 21H

    ; Get user input
    MOV AH, 01H   ; Keyboard input
    INT 21H
    SUB AL, 30H   ; Convert ASCII to numeric  
    
    ; Handle user input
    CMP AL, 1
    JE ADD_TSHIRT
    CMP AL, 2
    JE ADD_JACKET
    CMP AL, 3
    JE ADD_JEANS
    CMP AL, 4
    JE SHOW_MENU
    CMP AL, 5
    JE EXIT
    
    JMP INVALID_CHOICE
    
EXIT:
    ; Terminate program
    MOV AH, 4CH
    INT 21H
    
ADD_TSHIRT:
    ; Increment T-shirt count and price
    INC TSHIRT_COUNT
    MOV BX, TSHIRT_PRICE
    ADD BX, 200
    MOV TSHIRT_PRICE, BX
    CALL ADDED
    CALL FINAL
    JMP START

ADD_JACKET:
    ; Increment jacket count and price
    INC JACKET_COUNT
    MOV BX, JACKET_PRICE
    ADD BX, 250
    MOV JACKET_PRICE, BX
    CALL ADDED
    CALL FINAL
    JMP START
    
ADD_JEANS:
    ; Increment jeans count and price
    INC JEANS_COUNT
    MOV BX, JEANS_PRICE
    ADD BX, 300
    MOV JEANS_PRICE, BX
    CALL ADDED
    CALL FINAL
    JMP START
    
SHOW_MENU:
    ; display total t-shirts message
    LEA DX, MSG_N_TSHIRT
    MOV AH, 09H
    INT 21H
    
    ; Convert total t-shirts to ASCII 
    MOV AX, TSHIRT_COUNT
    MOV CX, 0         ; Counter for digits
NEXT_DIGIT_TSHIRTS:
    MOV DX, 0
    MOV bx, 10
    DIV bx   ; Divide AX by 10
    ADD DX, 30H       ; Convert remainder to ASCII
    PUSH DX           ; Store digit on stack
    INC CX            ; Increment digit counter
    CMP AX, 0         ; Check if AX is zero
    JNE NEXT_DIGIT_TSHIRTS
    
    ; Display total t-shirts
PRINT_DIGITS_TSHIRTS:
    POP DX            ; Retrieve digit from stack
    MOV AH, 02H       ; Print digit
    INT 21H
    LOOP PRINT_DIGITS_TSHIRTS ; Repeat for all digits
    
    ; display total jackets message
    LEA DX, MSG_N_JACKET
    MOV AH, 09H
    INT 21H
    
    ; Convert total jackets to ASCII 
    MOV AX, JACKET_COUNT
    MOV CX, 0         ; Counter for digits
NEXT_DIGIT_JACKETS:
    MOV DX, 0
    MOV bx, 10
    DIV bx   ; Divide AX by 10
    ADD DX, 30H       ; Convert remainder to ASCII
    PUSH DX           ; Store digit on stack
    INC CX            ; Increment digit counter
    CMP AX, 0         ; Check if AX is zero
    JNE NEXT_DIGIT_JACKETS
    
    ; Display total jackets
PRINT_DIGITS_JACKETS:
    POP DX            ; Retrieve digit from stack
    MOV AH, 02H       ; Print digit
    INT 21H
    LOOP PRINT_DIGITS_JACKETS ; Repeat for all digits
    
    ; display total jeans message
    LEA DX, MSG_N_JEANS
    MOV AH, 09H
    INT 21H
    
    ; Convert total jeans to ASCII 
    MOV AX, JEANS_COUNT
    MOV CX, 0         ; Counter for digits
NEXT_DIGIT_JEANS:
    MOV DX, 0
    MOV bx, 10
    DIV bx   ; Divide AX by 10
    ADD DX, 30H       ; Convert remainder to ASCII
    PUSH DX           ; Store digit on stack
    INC CX            ; Increment digit counter
    CMP AX, 0         ; Check if AX is zero
    JNE NEXT_DIGIT_JEANS
    
    ; Display total jeans
PRINT_DIGITS_JEANS:
    POP DX            ; Retrieve digit from stack
    MOV AH, 02H       ; Print digit
    INT 21H
    LOOP PRINT_DIGITS_JEANS ; Repeat for all digits
    
    ; Calculate total items
    MOV AX, TSHIRT_COUNT
    ADD AX, JACKET_COUNT
    ADD AX, JEANS_COUNT
    MOV TOTAL_COUNT, AX

    ; Display total items message
    LEA DX, MSG_TOTAL_ITEMS
    MOV AH, 09H
    INT 21H

    ; Convert total to ASCII 
    MOV AX, TOTAL_COUNT
    MOV CX, 0         ; Counter for digits
NEXT_DIGIT_ITEM:
    MOV DX, 0
    MOV bx, 10
    DIV bx   ; Divide AX by 10
    ADD DX, 30H       ; Convert remainder to ASCII
    PUSH DX           ; Store digit on stack
    INC CX            ; Increment digit counter
    CMP AX, 0         ; Check if AX is zero
    JNE NEXT_DIGIT_ITEM
    
    ; Display total items
PRINT_DIGITS_ITEM:
    POP DX            ; Retrieve digit from stack
    MOV AH, 02H       ; Print digit
    INT 21H
    LOOP PRINT_DIGITS_ITEM ; Repeat for all digits
    
    ; Calculate total price
    MOV AX, TSHIRT_PRICE
    ADD AX, JACKET_PRICE
    ADD AX, JEANS_PRICE
    MOV TOTAL_PRICE, AX

    ; Display total price message
    LEA DX, MSG_TOTAL_PRICE
    MOV AH, 09H
    INT 21H

    ; Convert total to ASCII 
    MOV AX, TOTAL_PRICE
    MOV CX, 0         ; Counter for digits
    NEXT_DIGIT_PRICE:
    MOV DX, 0
    MOV bx, 10
    DIV bx   ; Divide AX by 10
    ADD DX, 30H       ; Convert remainder to ASCII
    PUSH DX           ; Store digit on stack
    INC CX            ; Increment digit counter
    CMP AX, 0         ; Check if AX is zero
    JNE NEXT_DIGIT_PRICE
    
    ; Display total price
    PRINT_DIGITS_PRICE:
    POP DX            ; Retrieve digit from stack
    MOV AH, 02H       ; Print digit
    INT 21H
    LOOP PRINT_DIGITS_PRICE ; Repeat for all digits
    
    ; Display currency
    LEA DX, CURRENCY
    MOV AH, 09H
    INT 21H
    
    CALL FINAL
    JMP START

INVALID_CHOICE:
    ; Display invalid input message
    LEA DX, WRONG_INPUT
    MOV AH, 09H
    INT 21H
    CALL FINAL
    JMP START
    
MAIN ENDP

ADDED PROC NEAR
    LEA DX, ADD_MSG
    MOV AH, 09H
    INT 21H
    RET
ADDED ENDP

FINAL PROC NEAR
    LEA DX, MENU_END
    MOV AH, 09H
    INT 21H
    RET
FINAL ENDP

END MAIN