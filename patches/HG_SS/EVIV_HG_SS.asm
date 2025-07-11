; EVIV_HG_SS.asm

.nds
.thumb

; ------- Inject hook into arm9.bin -------
.open "arm9.bin", 0x02000000

.org 0x020899C4

    bl EV_IV_Viewer

.close

; ------- Write function to synthOverlay 0000 -------
.open "unpacked/synthOverlay/0000", 0x023C8000


INJECT_ADDR equ 0x023C8000
.org INJECT_ADDR
.ascii "EV IV Viewer"

EV_IV_Viewer:
    push {lr}
    bl 0x0206FD00   ; original function

    ldr  r3, =0x021D110C     ; gSystem
    ldr  r2, [r3, #0x44]     ; heldKeys
    ldr  r3, =0x0100         ; R button
    tst  r2, r3
    bne  .write_iv_ids

    ldr  r3, =0x021D110C
    ldr  r2, [r3, #0x44]
    ldr  r3, =0x0200         ; L button
    tst  r2, r3
    beq  .write_stats_ids

.write_ev_ids:
    ldr r0, =0x020899CC
    mov r1, #13
    strb r1, [r0]
    ldr r0, =0x020899D8
    mov r1, #13
    strb r1, [r0]
    ldr r0, =0x020899E4
    mov r1, #14
    strb r1, [r0]
    ldr r0, =0x020899F0
    mov r1, #15
    strb r1, [r0]
    ldr r0, =0x020899FC
    mov r1, #17
    strb r1, [r0]
    ldr r0, =0x02089A08
    mov r1, #18
    strb r1, [r0]
    ldr r0, =0x02089A14
    mov r1, #16
    strb r1, [r0]
    b .return

.write_iv_ids:
    ldr r0, =0x020899CC
    mov r1, #70
    strb r1, [r0]
    ldr r0, =0x020899D8
    mov r1, #70
    strb r1, [r0]
    ldr r0, =0x020899E4
    mov r1, #71
    strb r1, [r0]
    ldr r0, =0x020899F0
    mov r1, #72
    strb r1, [r0]
    ldr r0, =0x020899FC
    mov r1, #74
    strb r1, [r0]
    ldr r0, =0x02089A08
    mov r1, #75
    strb r1, [r0]
    ldr r0, =0x02089A14
    mov r1, #73
    strb r1, [r0]
    b .return

.write_stats_ids:
    ldr r0, =0x020899CC
    mov r1, #0xA3
    strb r1, [r0]
    ldr r0, =0x020899D8
    mov r1, #0xA4
    strb r1, [r0]
    ldr r0, =0x020899E4
    mov r1, #0xA5
    strb r1, [r0]
    ldr r0, =0x020899F0
    mov r1, #0xA6
    strb r1, [r0]
    ldr r0, =0x020899FC
    mov r1, #0xA8
    strb r1, [r0]
    ldr r0, =0x02089A08
    mov r1, #0xA9
    strb r1, [r0]
    ldr r0, =0x02089A14
    mov r1, #0xA7
    strb r1, [r0]

.return:
    pop {pc}

.pool

.close