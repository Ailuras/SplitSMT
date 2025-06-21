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

(declare-sort var1266 0)
(declare-sort var2590 0)
(declare-sort var2618 0)
(declare-sort var760 0)
(declare-sort var1968 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var2590) Int)
(declare-fun cast-from-var1266-to-var2590 (var1266) var2590)
(declare-fun var1266_getDescriptor/-1482855958 () var2618)
(declare-fun hashCode/1739917532 (var760) Int)
(declare-fun cast-from-var2618-to-var760 (var2618) var760)
(declare-fun getType/692552068 (var1266) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getSubject/946765680 (var1266) String)
(declare-fun getDescription/132294432 (var1266) String)
(declare-fun getUnknownFields/94315221 (var2590) var1968)
(declare-fun hashCode/247890256 (var1968) Int)
(declare-const null-var1266 var1266)
(declare-const var1774 var1266) ; Statement: r0 := @this: com.google.rpc.PreconditionFailure$Violation 
(assert (not (= var1774 null-var1266)))
(define-const var1121 Int (memoizedHashCode/623481040 (cast-from-var1266-to-var2590 var1774))) ; Statement: $i0 = r0.<com.google.rpc.PreconditionFailure$Violation: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.PreconditionFailure$Violation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var1121 0)) ; Cond: $i0 == 0 
(define-const var258 var2618 var1266_getDescriptor/-1482855958) ; Statement: $r1 = staticinvoke <com.google.rpc.PreconditionFailure$Violation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var2586 Int (hashCode/1739917532 (cast-from-var2618-to-var760 var258))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var3577 Int (+ 779 var2586)) ; Statement: i14 = 779 + $i1 
(define-const var1773 Int (* 37 var3577)) ; Statement: $i2 = 37 * i14 
(define-const var1581 Int (+ var1773 1)) ; Statement: i15 = $i2 + 1 
(define-const var308 Int (* 53 var1581)) ; Statement: $i4 = 53 * i15 
(assert true)
(define-const var3328 String (getType/692552068 var1774)) ; Statement: $r2 = virtualinvoke r0.<com.google.rpc.PreconditionFailure$Violation: java.lang.String getType()>() 
(assert true)
(define-const var2996 Int (hashCode/-467973558 var3328)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3287 Int (+ var308 var2996)) ; Statement: i16 = $i4 + $i3 
(define-const var893 Int (* 37 var3287)) ; Statement: $i5 = 37 * i16 
(define-const var2889 Int (+ var893 2)) ; Statement: i17 = $i5 + 2 
(define-const var1941 Int (* 53 var2889)) ; Statement: $i7 = 53 * i17 
(assert true)
(define-const var694 String (getSubject/946765680 var1774)) ; Statement: $r3 = virtualinvoke r0.<com.google.rpc.PreconditionFailure$Violation: java.lang.String getSubject()>() 
(assert true)
(define-const var1370 Int (hashCode/-467973558 var694)) ; Statement: $i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var3855 Int (+ var1941 var1370)) ; Statement: i18 = $i7 + $i6 
(define-const var866 Int (* 37 var3855)) ; Statement: $i8 = 37 * i18 
(define-const var3097 Int (+ var866 3)) ; Statement: i19 = $i8 + 3 
(define-const var1979 Int (* 53 var3097)) ; Statement: $i10 = 53 * i19 
(assert true)
(define-const var556 String (getDescription/132294432 var1774)) ; Statement: $r4 = virtualinvoke r0.<com.google.rpc.PreconditionFailure$Violation: java.lang.String getDescription()>() 
(assert true)
(define-const var1496 Int (hashCode/-467973558 var556)) ; Statement: $i9 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(define-const var1125 Int (+ var1979 var1496)) ; Statement: i20 = $i10 + $i9 
(define-const var2019 Int (* 29 var1125)) ; Statement: $i12 = 29 * i20 
(assert true)
(define-const var3203 var1968 (getUnknownFields/94315221 (cast-from-var1266-to-var2590 var1774))) ; Statement: $r5 = virtualinvoke r0.<com.google.rpc.PreconditionFailure$Violation: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var1705 Int (hashCode/247890256 var3203)) ; Statement: $i11 = virtualinvoke $r5.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var3571 Int (+ var2019 var1705)) ; Statement: i21 = $i12 + $i11 
(declare-const var1774!1 var1266)
(assert (not (= var1774!1 null-var1266)))
(assert (= (memoizedHashCode/623481040 (cast-from-var1266-to-var2590 var1774!1)) var3571)) ; Statement: r0.<com.google.rpc.PreconditionFailure$Violation: int memoizedHashCode> = i21 
 ; Statement: return i21 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var1266-to-var2590=([com.google.rpc.PreconditionFailure$Violation], com.google.protobuf.GeneratedMessageV3), var1266_getDescriptor/-1482855958=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var2618-to-var760=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getType/692552068=([com.google.rpc.PreconditionFailure$Violation], java.lang.String), hashCode/-467973558=([java.lang.String], int), getSubject/946765680=([com.google.rpc.PreconditionFailure$Violation], java.lang.String), getDescription/132294432=([com.google.rpc.PreconditionFailure$Violation], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var1266=com.google.rpc.PreconditionFailure$Violation, var1774=r0, var2590=com.google.protobuf.GeneratedMessageV3, var1121=$i0, var2618=com.google.protobuf.Descriptors$Descriptor, var258=$r1, var760=java.lang.Object, var2586=$i1, var3577=i14, var1773=$i2, var1581=i15, var308=$i4, var3328=$r2, var2996=$i3, var3287=i16, var893=$i5, var2889=i17, var1941=$i7, var694=$r3, var1370=$i6, var3855=i18, var866=$i8, var3097=i19, var1979=$i10, var556=$r4, var1496=$i9, var1125=i20, var2019=$i12, var1968=com.google.protobuf.UnknownFieldSet, var3203=$r5, var1705=$i11, var3571=i21}
; {com.google.rpc.PreconditionFailure$Violation=var1266, r0=var1774, com.google.protobuf.GeneratedMessageV3=var2590, $i0=var1121, com.google.protobuf.Descriptors$Descriptor=var2618, $r1=var258, java.lang.Object=var760, $i1=var2586, i14=var3577, $i2=var1773, i15=var1581, $i4=var308, $r2=var3328, $i3=var2996, i16=var3287, $i5=var893, i17=var2889, $i7=var1941, $r3=var694, $i6=var1370, i18=var3855, $i8=var866, i19=var3097, $i10=var1979, $r4=var556, $i9=var1496, i20=var1125, $i12=var2019, com.google.protobuf.UnknownFieldSet=var1968, $r5=var3203, $i11=var1705, i21=var3571}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 3}
;stmts r0 := @this: com.google.rpc.PreconditionFailure$Violation;	$i0 = r0.<com.google.rpc.PreconditionFailure$Violation: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.PreconditionFailure$Violation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <com.google.rpc.PreconditionFailure$Violation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i14 = 779 + $i1;	$i2 = 37 * i14;	i15 = $i2 + 1;	$i4 = 53 * i15;	$r2 = virtualinvoke r0.<com.google.rpc.PreconditionFailure$Violation: java.lang.String getType()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i16 = $i4 + $i3;	$i5 = 37 * i16;	i17 = $i5 + 2;	$i7 = 53 * i17;	$r3 = virtualinvoke r0.<com.google.rpc.PreconditionFailure$Violation: java.lang.String getSubject()>();	$i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	i18 = $i7 + $i6;	$i8 = 37 * i18;	i19 = $i8 + 3;	$i10 = 53 * i19;	$r4 = virtualinvoke r0.<com.google.rpc.PreconditionFailure$Violation: java.lang.String getDescription()>();	$i9 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	i20 = $i10 + $i9;	$i12 = 29 * i20;	$r5 = virtualinvoke r0.<com.google.rpc.PreconditionFailure$Violation: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i11 = virtualinvoke $r5.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i21 = $i12 + $i11;	r0.<com.google.rpc.PreconditionFailure$Violation: int memoizedHashCode> = i21;	return i21
;block_num 2