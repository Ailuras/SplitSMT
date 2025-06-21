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

(declare-sort var35 0)
(declare-sort var3131 0)
(declare-sort var3087 0)
(declare-sort var3367 0)
(declare-sort var662 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var3131) Int)
(declare-fun cast-from-var35-to-var3131 (var35) var3131)
(declare-fun var35_getDescriptor/-766962386 () var3087)
(declare-fun hashCode/1739917532 (var3367) Int)
(declare-fun cast-from-var3087-to-var3367 (var3087) var3367)
(declare-fun getContainingType/1659210778 (var35) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getExtensionNumber/1905754362 (var35) Int)
(declare-fun getUnknownFields/94315221 (var3131) var662)
(declare-fun hashCode/247890256 (var662) Int)
(declare-const null-var35 var35)
(declare-const var1627 var35) ; Statement: r0 := @this: io.grpc.reflection.v1alpha.ExtensionRequest 
(assert (not (= var1627 null-var35)))
(define-const var979 Int (memoizedHashCode/623481040 (cast-from-var35-to-var3131 var1627))) ; Statement: $i0 = r0.<io.grpc.reflection.v1alpha.ExtensionRequest: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <io.grpc.reflection.v1alpha.ExtensionRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var979 0)) ; Cond: $i0 == 0 
(define-const var1472 var3087 var35_getDescriptor/-766962386) ; Statement: $r1 = staticinvoke <io.grpc.reflection.v1alpha.ExtensionRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var2178 Int (hashCode/1739917532 (cast-from-var3087-to-var3367 var1472))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var2628 Int (+ 779 var2178)) ; Statement: i11 = 779 + $i1 
(define-const var994 Int (* 37 var2628)) ; Statement: $i2 = 37 * i11 
(define-const var1572 Int (+ var994 1)) ; Statement: i12 = $i2 + 1 
(define-const var3467 Int (* 53 var1572)) ; Statement: $i4 = 53 * i12 
(assert true)
(define-const var1901 String (getContainingType/1659210778 var1627)) ; Statement: $r2 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ExtensionRequest: java.lang.String getContainingType()>() 
(assert true)
(define-const var3757 Int (hashCode/-467973558 var1901)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3737 Int (+ var3467 var3757)) ; Statement: i13 = $i4 + $i3 
(define-const var1967 Int (* 37 var3737)) ; Statement: $i5 = 37 * i13 
(define-const var986 Int (+ var1967 2)) ; Statement: i14 = $i5 + 2 
(define-const var3364 Int (* 53 var986)) ; Statement: $i7 = 53 * i14 
(assert true)
(define-const var1809 Int (getExtensionNumber/1905754362 var1627)) ; Statement: $i6 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ExtensionRequest: int getExtensionNumber()>() 
(define-const var290 Int (+ var3364 var1809)) ; Statement: i15 = $i7 + $i6 
(define-const var3264 Int (* 29 var290)) ; Statement: $i9 = 29 * i15 
(assert true)
(define-const var3779 var662 (getUnknownFields/94315221 (cast-from-var35-to-var3131 var1627))) ; Statement: $r3 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ExtensionRequest: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var1466 Int (hashCode/247890256 var3779)) ; Statement: $i8 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var3104 Int (+ var3264 var1466)) ; Statement: i16 = $i9 + $i8 
(declare-const var1627!1 var35)
(assert (not (= var1627!1 null-var35)))
(assert (= (memoizedHashCode/623481040 (cast-from-var35-to-var3131 var1627!1)) var3104)) ; Statement: r0.<io.grpc.reflection.v1alpha.ExtensionRequest: int memoizedHashCode> = i16 
 ; Statement: return i16 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var35-to-var3131=([io.grpc.reflection.v1alpha.ExtensionRequest], com.google.protobuf.GeneratedMessageV3), var35_getDescriptor/-766962386=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var3087-to-var3367=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getContainingType/1659210778=([io.grpc.reflection.v1alpha.ExtensionRequest], java.lang.String), hashCode/-467973558=([java.lang.String], int), getExtensionNumber/1905754362=([io.grpc.reflection.v1alpha.ExtensionRequest], int), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var35=io.grpc.reflection.v1alpha.ExtensionRequest, var1627=r0, var3131=com.google.protobuf.GeneratedMessageV3, var979=$i0, var3087=com.google.protobuf.Descriptors$Descriptor, var1472=$r1, var3367=java.lang.Object, var2178=$i1, var2628=i11, var994=$i2, var1572=i12, var3467=$i4, var1901=$r2, var3757=$i3, var3737=i13, var1967=$i5, var986=i14, var3364=$i7, var1809=$i6, var290=i15, var3264=$i9, var662=com.google.protobuf.UnknownFieldSet, var3779=$r3, var1466=$i8, var3104=i16}
; {io.grpc.reflection.v1alpha.ExtensionRequest=var35, r0=var1627, com.google.protobuf.GeneratedMessageV3=var3131, $i0=var979, com.google.protobuf.Descriptors$Descriptor=var3087, $r1=var1472, java.lang.Object=var3367, $i1=var2178, i11=var2628, $i2=var994, i12=var1572, $i4=var3467, $r2=var1901, $i3=var3757, i13=var3737, $i5=var1967, i14=var986, $i7=var3364, $i6=var1809, i15=var290, $i9=var3264, com.google.protobuf.UnknownFieldSet=var662, $r3=var3779, $i8=var1466, i16=var3104}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: io.grpc.reflection.v1alpha.ExtensionRequest;	$i0 = r0.<io.grpc.reflection.v1alpha.ExtensionRequest: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <io.grpc.reflection.v1alpha.ExtensionRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <io.grpc.reflection.v1alpha.ExtensionRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i11 = 779 + $i1;	$i2 = 37 * i11;	i12 = $i2 + 1;	$i4 = 53 * i12;	$r2 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ExtensionRequest: java.lang.String getContainingType()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i13 = $i4 + $i3;	$i5 = 37 * i13;	i14 = $i5 + 2;	$i7 = 53 * i14;	$i6 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ExtensionRequest: int getExtensionNumber()>();	i15 = $i7 + $i6;	$i9 = 29 * i15;	$r3 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ExtensionRequest: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i8 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i16 = $i9 + $i8;	r0.<io.grpc.reflection.v1alpha.ExtensionRequest: int memoizedHashCode> = i16;	return i16
;block_num 2