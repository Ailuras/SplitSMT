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

(declare-sort var2462 0)
(declare-sort var2772 0)
(declare-sort var2903 0)
(declare-sort var3695 0)
(declare-sort var1002 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var2772) Int)
(declare-fun cast-from-var2462-to-var2772 (var2462) var2772)
(declare-fun var2462_getDescriptor/1695009024 () var2903)
(declare-fun hashCode/1739917532 (var3695) Int)
(declare-fun cast-from-var2903-to-var3695 (var2903) var3695)
(declare-fun getRequestId/-898236740 (var2462) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getServingData/527442736 (var2462) String)
(declare-fun getUnknownFields/94315221 (var2772) var1002)
(declare-fun hashCode/247890256 (var1002) Int)
(declare-const null-var2462 var2462)
(declare-const var311 var2462) ; Statement: r0 := @this: com.google.rpc.RequestInfo 
(assert (not (= var311 null-var2462)))
(define-const var954 Int (memoizedHashCode/623481040 (cast-from-var2462-to-var2772 var311))) ; Statement: $i0 = r0.<com.google.rpc.RequestInfo: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.RequestInfo: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var954 0)) ; Cond: $i0 == 0 
(define-const var1275 var2903 var2462_getDescriptor/1695009024) ; Statement: $r1 = staticinvoke <com.google.rpc.RequestInfo: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var1849 Int (hashCode/1739917532 (cast-from-var2903-to-var3695 var1275))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var236 Int (+ 779 var1849)) ; Statement: i11 = 779 + $i1 
(define-const var1982 Int (* 37 var236)) ; Statement: $i2 = 37 * i11 
(define-const var3257 Int (+ var1982 1)) ; Statement: i12 = $i2 + 1 
(define-const var3193 Int (* 53 var3257)) ; Statement: $i4 = 53 * i12 
(assert true)
(define-const var1749 String (getRequestId/-898236740 var311)) ; Statement: $r2 = virtualinvoke r0.<com.google.rpc.RequestInfo: java.lang.String getRequestId()>() 
(assert true)
(define-const var3976 Int (hashCode/-467973558 var1749)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3498 Int (+ var3193 var3976)) ; Statement: i13 = $i4 + $i3 
(define-const var2848 Int (* 37 var3498)) ; Statement: $i5 = 37 * i13 
(define-const var457 Int (+ var2848 2)) ; Statement: i14 = $i5 + 2 
(define-const var1461 Int (* 53 var457)) ; Statement: $i7 = 53 * i14 
(assert true)
(define-const var428 String (getServingData/527442736 var311)) ; Statement: $r3 = virtualinvoke r0.<com.google.rpc.RequestInfo: java.lang.String getServingData()>() 
(assert true)
(define-const var3075 Int (hashCode/-467973558 var428)) ; Statement: $i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var2209 Int (+ var1461 var3075)) ; Statement: i15 = $i7 + $i6 
(define-const var1454 Int (* 29 var2209)) ; Statement: $i9 = 29 * i15 
(assert true)
(define-const var1797 var1002 (getUnknownFields/94315221 (cast-from-var2462-to-var2772 var311))) ; Statement: $r4 = virtualinvoke r0.<com.google.rpc.RequestInfo: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var514 Int (hashCode/247890256 var1797)) ; Statement: $i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var2217 Int (+ var1454 var514)) ; Statement: i16 = $i9 + $i8 
(declare-const var311!1 var2462)
(assert (not (= var311!1 null-var2462)))
(assert (= (memoizedHashCode/623481040 (cast-from-var2462-to-var2772 var311!1)) var2217)) ; Statement: r0.<com.google.rpc.RequestInfo: int memoizedHashCode> = i16 
 ; Statement: return i16 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var2462-to-var2772=([com.google.rpc.RequestInfo], com.google.protobuf.GeneratedMessageV3), var2462_getDescriptor/1695009024=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var2903-to-var3695=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getRequestId/-898236740=([com.google.rpc.RequestInfo], java.lang.String), hashCode/-467973558=([java.lang.String], int), getServingData/527442736=([com.google.rpc.RequestInfo], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var2462=com.google.rpc.RequestInfo, var311=r0, var2772=com.google.protobuf.GeneratedMessageV3, var954=$i0, var2903=com.google.protobuf.Descriptors$Descriptor, var1275=$r1, var3695=java.lang.Object, var1849=$i1, var236=i11, var1982=$i2, var3257=i12, var3193=$i4, var1749=$r2, var3976=$i3, var3498=i13, var2848=$i5, var457=i14, var1461=$i7, var428=$r3, var3075=$i6, var2209=i15, var1454=$i9, var1002=com.google.protobuf.UnknownFieldSet, var1797=$r4, var514=$i8, var2217=i16}
; {com.google.rpc.RequestInfo=var2462, r0=var311, com.google.protobuf.GeneratedMessageV3=var2772, $i0=var954, com.google.protobuf.Descriptors$Descriptor=var2903, $r1=var1275, java.lang.Object=var3695, $i1=var1849, i11=var236, $i2=var1982, i12=var3257, $i4=var3193, $r2=var1749, $i3=var3976, i13=var3498, $i5=var2848, i14=var457, $i7=var1461, $r3=var428, $i6=var3075, i15=var2209, $i9=var1454, com.google.protobuf.UnknownFieldSet=var1002, $r4=var1797, $i8=var514, i16=var2217}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: com.google.rpc.RequestInfo;	$i0 = r0.<com.google.rpc.RequestInfo: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.RequestInfo: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <com.google.rpc.RequestInfo: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i11 = 779 + $i1;	$i2 = 37 * i11;	i12 = $i2 + 1;	$i4 = 53 * i12;	$r2 = virtualinvoke r0.<com.google.rpc.RequestInfo: java.lang.String getRequestId()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i13 = $i4 + $i3;	$i5 = 37 * i13;	i14 = $i5 + 2;	$i7 = 53 * i14;	$r3 = virtualinvoke r0.<com.google.rpc.RequestInfo: java.lang.String getServingData()>();	$i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	i15 = $i7 + $i6;	$i9 = 29 * i15;	$r4 = virtualinvoke r0.<com.google.rpc.RequestInfo: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i16 = $i9 + $i8;	r0.<com.google.rpc.RequestInfo: int memoizedHashCode> = i16;	return i16
;block_num 2