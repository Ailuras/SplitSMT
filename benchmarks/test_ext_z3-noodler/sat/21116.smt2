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

(declare-sort var2566 0)
(declare-sort var2896 0)
(declare-sort var2595 0)
(declare-sort var1094 0)
(declare-sort var3988 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var2896) Int)
(declare-fun cast-from-var2566-to-var2896 (var2566) var2896)
(declare-fun var2566_getDescriptor/-1163460505 () var2595)
(declare-fun hashCode/1739917532 (var1094) Int)
(declare-fun cast-from-var2595-to-var1094 (var2595) var1094)
(declare-fun getLocale/-1264260767 (var2566) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getMessage/759884568 (var2566) String)
(declare-fun getUnknownFields/94315221 (var2896) var3988)
(declare-fun hashCode/247890256 (var3988) Int)
(declare-const null-var2566 var2566)
(declare-const var1867 var2566) ; Statement: r0 := @this: com.google.rpc.LocalizedMessage 
(assert (not (= var1867 null-var2566)))
(define-const var590 Int (memoizedHashCode/623481040 (cast-from-var2566-to-var2896 var1867))) ; Statement: $i0 = r0.<com.google.rpc.LocalizedMessage: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.LocalizedMessage: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var590 0)) ; Cond: $i0 == 0 
(define-const var2399 var2595 var2566_getDescriptor/-1163460505) ; Statement: $r1 = staticinvoke <com.google.rpc.LocalizedMessage: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var796 Int (hashCode/1739917532 (cast-from-var2595-to-var1094 var2399))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var1813 Int (+ 779 var796)) ; Statement: i11 = 779 + $i1 
(define-const var22 Int (* 37 var1813)) ; Statement: $i2 = 37 * i11 
(define-const var3172 Int (+ var22 1)) ; Statement: i12 = $i2 + 1 
(define-const var3604 Int (* 53 var3172)) ; Statement: $i4 = 53 * i12 
(assert true)
(define-const var3641 String (getLocale/-1264260767 var1867)) ; Statement: $r2 = virtualinvoke r0.<com.google.rpc.LocalizedMessage: java.lang.String getLocale()>() 
(assert true)
(define-const var1033 Int (hashCode/-467973558 var3641)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var2924 Int (+ var3604 var1033)) ; Statement: i13 = $i4 + $i3 
(define-const var2652 Int (* 37 var2924)) ; Statement: $i5 = 37 * i13 
(define-const var2833 Int (+ var2652 2)) ; Statement: i14 = $i5 + 2 
(define-const var79 Int (* 53 var2833)) ; Statement: $i7 = 53 * i14 
(assert true)
(define-const var1689 String (getMessage/759884568 var1867)) ; Statement: $r3 = virtualinvoke r0.<com.google.rpc.LocalizedMessage: java.lang.String getMessage()>() 
(assert true)
(define-const var597 Int (hashCode/-467973558 var1689)) ; Statement: $i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var1064 Int (+ var79 var597)) ; Statement: i15 = $i7 + $i6 
(define-const var84 Int (* 29 var1064)) ; Statement: $i9 = 29 * i15 
(assert true)
(define-const var2423 var3988 (getUnknownFields/94315221 (cast-from-var2566-to-var2896 var1867))) ; Statement: $r4 = virtualinvoke r0.<com.google.rpc.LocalizedMessage: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var3451 Int (hashCode/247890256 var2423)) ; Statement: $i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var92 Int (+ var84 var3451)) ; Statement: i16 = $i9 + $i8 
(declare-const var1867!1 var2566)
(assert (not (= var1867!1 null-var2566)))
(assert (= (memoizedHashCode/623481040 (cast-from-var2566-to-var2896 var1867!1)) var92)) ; Statement: r0.<com.google.rpc.LocalizedMessage: int memoizedHashCode> = i16 
 ; Statement: return i16 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var2566-to-var2896=([com.google.rpc.LocalizedMessage], com.google.protobuf.GeneratedMessageV3), var2566_getDescriptor/-1163460505=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var2595-to-var1094=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getLocale/-1264260767=([com.google.rpc.LocalizedMessage], java.lang.String), hashCode/-467973558=([java.lang.String], int), getMessage/759884568=([com.google.rpc.LocalizedMessage], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var2566=com.google.rpc.LocalizedMessage, var1867=r0, var2896=com.google.protobuf.GeneratedMessageV3, var590=$i0, var2595=com.google.protobuf.Descriptors$Descriptor, var2399=$r1, var1094=java.lang.Object, var796=$i1, var1813=i11, var22=$i2, var3172=i12, var3604=$i4, var3641=$r2, var1033=$i3, var2924=i13, var2652=$i5, var2833=i14, var79=$i7, var1689=$r3, var597=$i6, var1064=i15, var84=$i9, var3988=com.google.protobuf.UnknownFieldSet, var2423=$r4, var3451=$i8, var92=i16}
; {com.google.rpc.LocalizedMessage=var2566, r0=var1867, com.google.protobuf.GeneratedMessageV3=var2896, $i0=var590, com.google.protobuf.Descriptors$Descriptor=var2595, $r1=var2399, java.lang.Object=var1094, $i1=var796, i11=var1813, $i2=var22, i12=var3172, $i4=var3604, $r2=var3641, $i3=var1033, i13=var2924, $i5=var2652, i14=var2833, $i7=var79, $r3=var1689, $i6=var597, i15=var1064, $i9=var84, com.google.protobuf.UnknownFieldSet=var3988, $r4=var2423, $i8=var3451, i16=var92}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: com.google.rpc.LocalizedMessage;	$i0 = r0.<com.google.rpc.LocalizedMessage: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.LocalizedMessage: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <com.google.rpc.LocalizedMessage: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i11 = 779 + $i1;	$i2 = 37 * i11;	i12 = $i2 + 1;	$i4 = 53 * i12;	$r2 = virtualinvoke r0.<com.google.rpc.LocalizedMessage: java.lang.String getLocale()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i13 = $i4 + $i3;	$i5 = 37 * i13;	i14 = $i5 + 2;	$i7 = 53 * i14;	$r3 = virtualinvoke r0.<com.google.rpc.LocalizedMessage: java.lang.String getMessage()>();	$i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	i15 = $i7 + $i6;	$i9 = 29 * i15;	$r4 = virtualinvoke r0.<com.google.rpc.LocalizedMessage: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i16 = $i9 + $i8;	r0.<com.google.rpc.LocalizedMessage: int memoizedHashCode> = i16;	return i16
;block_num 2