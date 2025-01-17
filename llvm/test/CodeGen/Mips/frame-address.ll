; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=mipsel-elf < %s | FileCheck %s

declare ptr @llvm.frameaddress(i32) nounwind readnone

define ptr @f() nounwind uwtable {
; CHECK-LABEL: f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addiu $sp, $sp, -8
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    sw $ra, 4($sp) # 4-byte Folded Spill
; CHECK-NEXT:    sw $fp, 0($sp) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset 31, -4
; CHECK-NEXT:    .cfi_offset 30, -8
; CHECK-NEXT:    move $fp, $sp
; CHECK-NEXT:    .cfi_def_cfa_register 30
; CHECK-NEXT:    move $2, $fp
; CHECK-NEXT:    move $sp, $fp
; CHECK-NEXT:    lw $fp, 0($sp) # 4-byte Folded Reload
; CHECK-NEXT:    lw $ra, 4($sp) # 4-byte Folded Reload
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    addiu $sp, $sp, 8
entry:
  %0 = call ptr @llvm.frameaddress(i32 0)
  ret ptr %0
}
