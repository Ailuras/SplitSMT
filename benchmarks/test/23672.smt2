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

(declare-sort var335 0)
(declare-sort var3929 0)
(declare-sort var1283 0)
(declare-sort var610 0)
(declare-sort var3563 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var3929) Int)
(declare-fun cast-from-var335-to-var3929 (var335) var3929)
(declare-fun var335_getDescriptor/-158191108 () var1283)
(declare-fun hashCode/1739917532 (var610) Int)
(declare-fun cast-from-var1283-to-var610 (var1283) var610)
(declare-fun getName/1120737445 (var335) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getUnknownFields/94315221 (var3929) var3563)
(declare-fun hashCode/247890256 (var3563) Int)
(declare-const null-var335 var335)
(declare-const var845 var335) ; Statement: r0 := @this: io.grpc.reflection.v1alpha.ServiceResponse 
(assert (not (= var845 null-var335)))
(define-const var3933 Int (memoizedHashCode/623481040 (cast-from-var335-to-var3929 var845))) ; Statement: $i0 = r0.<io.grpc.reflection.v1alpha.ServiceResponse: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <io.grpc.reflection.v1alpha.ServiceResponse: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var3933 0)) ; Cond: $i0 == 0 
(define-const var2901 var1283 var335_getDescriptor/-158191108) ; Statement: $r1 = staticinvoke <io.grpc.reflection.v1alpha.ServiceResponse: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var1777 Int (hashCode/1739917532 (cast-from-var1283-to-var610 var2901))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var1234 Int (+ 779 var1777)) ; Statement: i8 = 779 + $i1 
(define-const var1421 Int (* 37 var1234)) ; Statement: $i2 = 37 * i8 
(define-const var3362 Int (+ var1421 1)) ; Statement: i9 = $i2 + 1 
(define-const var3105 Int (* 53 var3362)) ; Statement: $i4 = 53 * i9 
(assert true)
(define-const var3558 String (getName/1120737445 var845)) ; Statement: $r2 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ServiceResponse: java.lang.String getName()>() 
(assert true)
(define-const var688 Int (hashCode/-467973558 var3558)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3098 Int (+ var3105 var688)) ; Statement: i10 = $i4 + $i3 
(define-const var1462 Int (* 29 var3098)) ; Statement: $i6 = 29 * i10 
(assert true)
(define-const var1750 var3563 (getUnknownFields/94315221 (cast-from-var335-to-var3929 var845))) ; Statement: $r3 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ServiceResponse: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var160 Int (hashCode/247890256 var1750)) ; Statement: $i5 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var3648 Int (+ var1462 var160)) ; Statement: i11 = $i6 + $i5 
(declare-const var845!1 var335)
(assert (not (= var845!1 null-var335)))
(assert (= (memoizedHashCode/623481040 (cast-from-var335-to-var3929 var845!1)) var3648)) ; Statement: r0.<io.grpc.reflection.v1alpha.ServiceResponse: int memoizedHashCode> = i11 
 ; Statement: return i11 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var335-to-var3929=([io.grpc.reflection.v1alpha.ServiceResponse], com.google.protobuf.GeneratedMessageV3), var335_getDescriptor/-158191108=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var1283-to-var610=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getName/1120737445=([io.grpc.reflection.v1alpha.ServiceResponse], java.lang.String), hashCode/-467973558=([java.lang.String], int), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var335=io.grpc.reflection.v1alpha.ServiceResponse, var845=r0, var3929=com.google.protobuf.GeneratedMessageV3, var3933=$i0, var1283=com.google.protobuf.Descriptors$Descriptor, var2901=$r1, var610=java.lang.Object, var1777=$i1, var1234=i8, var1421=$i2, var3362=i9, var3105=$i4, var3558=$r2, var688=$i3, var3098=i10, var1462=$i6, var3563=com.google.protobuf.UnknownFieldSet, var1750=$r3, var160=$i5, var3648=i11}
; {io.grpc.reflection.v1alpha.ServiceResponse=var335, r0=var845, com.google.protobuf.GeneratedMessageV3=var3929, $i0=var3933, com.google.protobuf.Descriptors$Descriptor=var1283, $r1=var2901, java.lang.Object=var610, $i1=var1777, i8=var1234, $i2=var1421, i9=var3362, $i4=var3105, $r2=var3558, $i3=var688, i10=var3098, $i6=var1462, com.google.protobuf.UnknownFieldSet=var3563, $r3=var1750, $i5=var160, i11=var3648}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: io.grpc.reflection.v1alpha.ServiceResponse;	$i0 = r0.<io.grpc.reflection.v1alpha.ServiceResponse: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <io.grpc.reflection.v1alpha.ServiceResponse: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <io.grpc.reflection.v1alpha.ServiceResponse: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i8 = 779 + $i1;	$i2 = 37 * i8;	i9 = $i2 + 1;	$i4 = 53 * i9;	$r2 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ServiceResponse: java.lang.String getName()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i10 = $i4 + $i3;	$i6 = 29 * i10;	$r3 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ServiceResponse: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i5 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i11 = $i6 + $i5;	r0.<io.grpc.reflection.v1alpha.ServiceResponse: int memoizedHashCode> = i11;	return i11
;block_num 2