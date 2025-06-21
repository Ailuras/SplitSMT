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

(declare-sort var3888 0)
(declare-sort var2040 0)
(declare-sort var2618 0)
(declare-sort var3769 0)
(declare-sort var377 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var2040) Int)
(declare-fun cast-from-var3888-to-var2040 (var3888) var2040)
(declare-fun var3888_getDescriptor/352646409 () var2618)
(declare-fun hashCode/1739917532 (var3769) Int)
(declare-fun cast-from-var2618-to-var3769 (var2618) var3769)
(declare-fun getErrorCode/1551404232 (var3888) Int)
(declare-fun getErrorMessage/-888075042 (var3888) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getUnknownFields/94315221 (var2040) var377)
(declare-fun hashCode/247890256 (var377) Int)
(declare-const null-var3888 var3888)
(declare-const var1948 var3888) ; Statement: r0 := @this: io.grpc.reflection.v1alpha.ErrorResponse 
(assert (not (= var1948 null-var3888)))
(define-const var3577 Int (memoizedHashCode/623481040 (cast-from-var3888-to-var2040 var1948))) ; Statement: $i0 = r0.<io.grpc.reflection.v1alpha.ErrorResponse: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <io.grpc.reflection.v1alpha.ErrorResponse: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var3577 0)) ; Cond: $i0 == 0 
(define-const var2110 var2618 var3888_getDescriptor/352646409) ; Statement: $r1 = staticinvoke <io.grpc.reflection.v1alpha.ErrorResponse: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var865 Int (hashCode/1739917532 (cast-from-var2618-to-var3769 var2110))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var721 Int (+ 779 var865)) ; Statement: i11 = 779 + $i1 
(define-const var652 Int (* 37 var721)) ; Statement: $i2 = 37 * i11 
(define-const var2158 Int (+ var652 1)) ; Statement: i12 = $i2 + 1 
(define-const var3895 Int (* 53 var2158)) ; Statement: $i4 = 53 * i12 
(assert true)
(define-const var1687 Int (getErrorCode/1551404232 var1948)) ; Statement: $i3 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ErrorResponse: int getErrorCode()>() 
(define-const var1951 Int (+ var3895 var1687)) ; Statement: i13 = $i4 + $i3 
(define-const var1501 Int (* 37 var1951)) ; Statement: $i5 = 37 * i13 
(define-const var3733 Int (+ var1501 2)) ; Statement: i14 = $i5 + 2 
(define-const var3959 Int (* 53 var3733)) ; Statement: $i7 = 53 * i14 
(assert true)
(define-const var447 String (getErrorMessage/-888075042 var1948)) ; Statement: $r2 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ErrorResponse: java.lang.String getErrorMessage()>() 
(assert true)
(define-const var1701 Int (hashCode/-467973558 var447)) ; Statement: $i6 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var1413 Int (+ var3959 var1701)) ; Statement: i15 = $i7 + $i6 
(define-const var812 Int (* 29 var1413)) ; Statement: $i9 = 29 * i15 
(assert true)
(define-const var1421 var377 (getUnknownFields/94315221 (cast-from-var3888-to-var2040 var1948))) ; Statement: $r3 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ErrorResponse: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var173 Int (hashCode/247890256 var1421)) ; Statement: $i8 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var2903 Int (+ var812 var173)) ; Statement: i16 = $i9 + $i8 
(declare-const var1948!1 var3888)
(assert (not (= var1948!1 null-var3888)))
(assert (= (memoizedHashCode/623481040 (cast-from-var3888-to-var2040 var1948!1)) var2903)) ; Statement: r0.<io.grpc.reflection.v1alpha.ErrorResponse: int memoizedHashCode> = i16 
 ; Statement: return i16 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var3888-to-var2040=([io.grpc.reflection.v1alpha.ErrorResponse], com.google.protobuf.GeneratedMessageV3), var3888_getDescriptor/352646409=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var2618-to-var3769=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getErrorCode/1551404232=([io.grpc.reflection.v1alpha.ErrorResponse], int), getErrorMessage/-888075042=([io.grpc.reflection.v1alpha.ErrorResponse], java.lang.String), hashCode/-467973558=([java.lang.String], int), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var3888=io.grpc.reflection.v1alpha.ErrorResponse, var1948=r0, var2040=com.google.protobuf.GeneratedMessageV3, var3577=$i0, var2618=com.google.protobuf.Descriptors$Descriptor, var2110=$r1, var3769=java.lang.Object, var865=$i1, var721=i11, var652=$i2, var2158=i12, var3895=$i4, var1687=$i3, var1951=i13, var1501=$i5, var3733=i14, var3959=$i7, var447=$r2, var1701=$i6, var1413=i15, var812=$i9, var377=com.google.protobuf.UnknownFieldSet, var1421=$r3, var173=$i8, var2903=i16}
; {io.grpc.reflection.v1alpha.ErrorResponse=var3888, r0=var1948, com.google.protobuf.GeneratedMessageV3=var2040, $i0=var3577, com.google.protobuf.Descriptors$Descriptor=var2618, $r1=var2110, java.lang.Object=var3769, $i1=var865, i11=var721, $i2=var652, i12=var2158, $i4=var3895, $i3=var1687, i13=var1951, $i5=var1501, i14=var3733, $i7=var3959, $r2=var447, $i6=var1701, i15=var1413, $i9=var812, com.google.protobuf.UnknownFieldSet=var377, $r3=var1421, $i8=var173, i16=var2903}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: io.grpc.reflection.v1alpha.ErrorResponse;	$i0 = r0.<io.grpc.reflection.v1alpha.ErrorResponse: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <io.grpc.reflection.v1alpha.ErrorResponse: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <io.grpc.reflection.v1alpha.ErrorResponse: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i11 = 779 + $i1;	$i2 = 37 * i11;	i12 = $i2 + 1;	$i4 = 53 * i12;	$i3 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ErrorResponse: int getErrorCode()>();	i13 = $i4 + $i3;	$i5 = 37 * i13;	i14 = $i5 + 2;	$i7 = 53 * i14;	$r2 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ErrorResponse: java.lang.String getErrorMessage()>();	$i6 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i15 = $i7 + $i6;	$i9 = 29 * i15;	$r3 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ErrorResponse: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i8 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i16 = $i9 + $i8;	r0.<io.grpc.reflection.v1alpha.ErrorResponse: int memoizedHashCode> = i16;	return i16
;block_num 2