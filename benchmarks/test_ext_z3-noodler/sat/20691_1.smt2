(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1478 0)
(declare-sort var390 0)
(declare-sort var1640 0)
(declare-sort var856 0)
(declare-sort var3177 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var390) Int)
(declare-fun cast-from-var1478-to-var390 (var1478) var390)
(declare-fun var1478_getDescriptor/215394968 () var1640)
(declare-fun hashCode/1739917532 (var856) Int)
(declare-fun cast-from-var1640-to-var856 (var1640) var856)
(declare-fun getField/-1490765388 (var1478) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getDescription/-1281315150 (var1478) String)
(declare-fun getUnknownFields/94315221 (var390) var3177)
(declare-fun hashCode/247890256 (var3177) Int)
(declare-const null-var1478 var1478)
(declare-const var3815 var1478) ; Statement: r0 := @this: com.google.rpc.BadRequest$FieldViolation 
(assert (not (= var3815 null-var1478)))
(define-const var1746 Int (memoizedHashCode/623481040 (cast-from-var1478-to-var390 var3815))) ; Statement: $i0 = r0.<com.google.rpc.BadRequest$FieldViolation: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.BadRequest$FieldViolation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var1746 0)) ; Cond: $i0 == 0 
(define-const var2022 var1640 var1478_getDescriptor/215394968) ; Statement: $r1 = staticinvoke <com.google.rpc.BadRequest$FieldViolation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var1071 Int (hashCode/1739917532 (cast-from-var1640-to-var856 var2022))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var3982 Int (+ 779 var1071)) ; Statement: i11 = 779 + $i1 
(define-const var855 Int (* 37 var3982)) ; Statement: $i2 = 37 * i11 
(define-const var3719 Int (+ var855 1)) ; Statement: i12 = $i2 + 1 
(define-const var1063 Int (* 53 var3719)) ; Statement: $i4 = 53 * i12 
(assert true)
(define-const var2034 String (getField/-1490765388 var3815)) ; Statement: $r2 = virtualinvoke r0.<com.google.rpc.BadRequest$FieldViolation: java.lang.String getField()>() 
(assert true)
(define-const var3526 Int (hashCode/-467973558 var2034)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3681 Int (+ var1063 var3526)) ; Statement: i13 = $i4 + $i3 
(define-const var1669 Int (* 37 var3681)) ; Statement: $i5 = 37 * i13 
(define-const var747 Int (+ var1669 2)) ; Statement: i14 = $i5 + 2 
(define-const var380 Int (* 53 var747)) ; Statement: $i7 = 53 * i14 
(assert true)
(define-const var120 String (getDescription/-1281315150 var3815)) ; Statement: $r3 = virtualinvoke r0.<com.google.rpc.BadRequest$FieldViolation: java.lang.String getDescription()>() 
(assert true)
(define-const var3307 Int (hashCode/-467973558 var120)) ; Statement: $i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var2991 Int (+ var380 var3307)) ; Statement: i15 = $i7 + $i6 
(define-const var111 Int (* 29 var2991)) ; Statement: $i9 = 29 * i15 
(assert true)
(define-const var3658 var3177 (getUnknownFields/94315221 (cast-from-var1478-to-var390 var3815))) ; Statement: $r4 = virtualinvoke r0.<com.google.rpc.BadRequest$FieldViolation: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var647 Int (hashCode/247890256 var3658)) ; Statement: $i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var3462 Int (+ var111 var647)) ; Statement: i16 = $i9 + $i8 
(declare-const var3815!1 var1478)
(assert (not (= var3815!1 null-var1478)))
(assert (= (memoizedHashCode/623481040 (cast-from-var1478-to-var390 var3815!1)) var3462)) ; Statement: r0.<com.google.rpc.BadRequest$FieldViolation: int memoizedHashCode> = i16 
 ; Statement: return i16 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var1478-to-var390=([com.google.rpc.BadRequest$FieldViolation], com.google.protobuf.GeneratedMessageV3), var1478_getDescriptor/215394968=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var1640-to-var856=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getField/-1490765388=([com.google.rpc.BadRequest$FieldViolation], java.lang.String), hashCode/-467973558=([java.lang.String], int), getDescription/-1281315150=([com.google.rpc.BadRequest$FieldViolation], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var1478=com.google.rpc.BadRequest$FieldViolation, var3815=r0, var390=com.google.protobuf.GeneratedMessageV3, var1746=$i0, var1640=com.google.protobuf.Descriptors$Descriptor, var2022=$r1, var856=java.lang.Object, var1071=$i1, var3982=i11, var855=$i2, var3719=i12, var1063=$i4, var2034=$r2, var3526=$i3, var3681=i13, var1669=$i5, var747=i14, var380=$i7, var120=$r3, var3307=$i6, var2991=i15, var111=$i9, var3177=com.google.protobuf.UnknownFieldSet, var3658=$r4, var647=$i8, var3462=i16}
; {com.google.rpc.BadRequest$FieldViolation=var1478, r0=var3815, com.google.protobuf.GeneratedMessageV3=var390, $i0=var1746, com.google.protobuf.Descriptors$Descriptor=var1640, $r1=var2022, java.lang.Object=var856, $i1=var1071, i11=var3982, $i2=var855, i12=var3719, $i4=var1063, $r2=var2034, $i3=var3526, i13=var3681, $i5=var1669, i14=var747, $i7=var380, $r3=var120, $i6=var3307, i15=var2991, $i9=var111, com.google.protobuf.UnknownFieldSet=var3177, $r4=var3658, $i8=var647, i16=var3462}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: com.google.rpc.BadRequest$FieldViolation;	$i0 = r0.<com.google.rpc.BadRequest$FieldViolation: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.BadRequest$FieldViolation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <com.google.rpc.BadRequest$FieldViolation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i11 = 779 + $i1;	$i2 = 37 * i11;	i12 = $i2 + 1;	$i4 = 53 * i12;	$r2 = virtualinvoke r0.<com.google.rpc.BadRequest$FieldViolation: java.lang.String getField()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i13 = $i4 + $i3;	$i5 = 37 * i13;	i14 = $i5 + 2;	$i7 = 53 * i14;	$r3 = virtualinvoke r0.<com.google.rpc.BadRequest$FieldViolation: java.lang.String getDescription()>();	$i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	i15 = $i7 + $i6;	$i9 = 29 * i15;	$r4 = virtualinvoke r0.<com.google.rpc.BadRequest$FieldViolation: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i16 = $i9 + $i8;	r0.<com.google.rpc.BadRequest$FieldViolation: int memoizedHashCode> = i16;	return i16
;block_num 2