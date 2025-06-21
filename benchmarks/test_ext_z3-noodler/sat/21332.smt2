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

(declare-sort var3935 0)
(declare-sort var891 0)
(declare-sort var3914 0)
(declare-sort var3117 0)
(declare-sort var1298 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var891) Int)
(declare-fun cast-from-var3935-to-var891 (var3935) var891)
(declare-fun var3935_getDescriptor/1156335296 () var3914)
(declare-fun hashCode/1739917532 (var3117) Int)
(declare-fun cast-from-var3914-to-var3117 (var3914) var3117)
(declare-fun getSubject/-1434742054 (var3935) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getDescription/-1123814006 (var3935) String)
(declare-fun getUnknownFields/94315221 (var891) var1298)
(declare-fun hashCode/247890256 (var1298) Int)
(declare-const null-var3935 var3935)
(declare-const var3129 var3935) ; Statement: r0 := @this: com.google.rpc.QuotaFailure$Violation 
(assert (not (= var3129 null-var3935)))
(define-const var99 Int (memoizedHashCode/623481040 (cast-from-var3935-to-var891 var3129))) ; Statement: $i0 = r0.<com.google.rpc.QuotaFailure$Violation: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.QuotaFailure$Violation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var99 0)) ; Cond: $i0 == 0 
(define-const var3044 var3914 var3935_getDescriptor/1156335296) ; Statement: $r1 = staticinvoke <com.google.rpc.QuotaFailure$Violation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var2995 Int (hashCode/1739917532 (cast-from-var3914-to-var3117 var3044))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var2067 Int (+ 779 var2995)) ; Statement: i11 = 779 + $i1 
(define-const var2901 Int (* 37 var2067)) ; Statement: $i2 = 37 * i11 
(define-const var3814 Int (+ var2901 1)) ; Statement: i12 = $i2 + 1 
(define-const var1655 Int (* 53 var3814)) ; Statement: $i4 = 53 * i12 
(assert true)
(define-const var603 String (getSubject/-1434742054 var3129)) ; Statement: $r2 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getSubject()>() 
(assert true)
(define-const var2583 Int (hashCode/-467973558 var603)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var1135 Int (+ var1655 var2583)) ; Statement: i13 = $i4 + $i3 
(define-const var963 Int (* 37 var1135)) ; Statement: $i5 = 37 * i13 
(define-const var3435 Int (+ var963 2)) ; Statement: i14 = $i5 + 2 
(define-const var1689 Int (* 53 var3435)) ; Statement: $i7 = 53 * i14 
(assert true)
(define-const var816 String (getDescription/-1123814006 var3129)) ; Statement: $r3 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getDescription()>() 
(assert true)
(define-const var2188 Int (hashCode/-467973558 var816)) ; Statement: $i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var2339 Int (+ var1689 var2188)) ; Statement: i15 = $i7 + $i6 
(define-const var1561 Int (* 29 var2339)) ; Statement: $i9 = 29 * i15 
(assert true)
(define-const var17 var1298 (getUnknownFields/94315221 (cast-from-var3935-to-var891 var3129))) ; Statement: $r4 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var3001 Int (hashCode/247890256 var17)) ; Statement: $i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var2638 Int (+ var1561 var3001)) ; Statement: i16 = $i9 + $i8 
(declare-const var3129!1 var3935)
(assert (not (= var3129!1 null-var3935)))
(assert (= (memoizedHashCode/623481040 (cast-from-var3935-to-var891 var3129!1)) var2638)) ; Statement: r0.<com.google.rpc.QuotaFailure$Violation: int memoizedHashCode> = i16 
 ; Statement: return i16 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var3935-to-var891=([com.google.rpc.QuotaFailure$Violation], com.google.protobuf.GeneratedMessageV3), var3935_getDescriptor/1156335296=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var3914-to-var3117=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getSubject/-1434742054=([com.google.rpc.QuotaFailure$Violation], java.lang.String), hashCode/-467973558=([java.lang.String], int), getDescription/-1123814006=([com.google.rpc.QuotaFailure$Violation], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var3935=com.google.rpc.QuotaFailure$Violation, var3129=r0, var891=com.google.protobuf.GeneratedMessageV3, var99=$i0, var3914=com.google.protobuf.Descriptors$Descriptor, var3044=$r1, var3117=java.lang.Object, var2995=$i1, var2067=i11, var2901=$i2, var3814=i12, var1655=$i4, var603=$r2, var2583=$i3, var1135=i13, var963=$i5, var3435=i14, var1689=$i7, var816=$r3, var2188=$i6, var2339=i15, var1561=$i9, var1298=com.google.protobuf.UnknownFieldSet, var17=$r4, var3001=$i8, var2638=i16}
; {com.google.rpc.QuotaFailure$Violation=var3935, r0=var3129, com.google.protobuf.GeneratedMessageV3=var891, $i0=var99, com.google.protobuf.Descriptors$Descriptor=var3914, $r1=var3044, java.lang.Object=var3117, $i1=var2995, i11=var2067, $i2=var2901, i12=var3814, $i4=var1655, $r2=var603, $i3=var2583, i13=var1135, $i5=var963, i14=var3435, $i7=var1689, $r3=var816, $i6=var2188, i15=var2339, $i9=var1561, com.google.protobuf.UnknownFieldSet=var1298, $r4=var17, $i8=var3001, i16=var2638}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: com.google.rpc.QuotaFailure$Violation;	$i0 = r0.<com.google.rpc.QuotaFailure$Violation: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.QuotaFailure$Violation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <com.google.rpc.QuotaFailure$Violation: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i11 = 779 + $i1;	$i2 = 37 * i11;	i12 = $i2 + 1;	$i4 = 53 * i12;	$r2 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getSubject()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i13 = $i4 + $i3;	$i5 = 37 * i13;	i14 = $i5 + 2;	$i7 = 53 * i14;	$r3 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getDescription()>();	$i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	i15 = $i7 + $i6;	$i9 = 29 * i15;	$r4 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i16 = $i9 + $i8;	r0.<com.google.rpc.QuotaFailure$Violation: int memoizedHashCode> = i16;	return i16
;block_num 2