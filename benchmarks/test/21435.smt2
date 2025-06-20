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

(declare-sort var2761 0)
(declare-sort var233 0)
(declare-sort var1795 0)
(declare-sort var2032 0)
(declare-sort var1791 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var233) Int)
(declare-fun cast-from-var2761-to-var233 (var2761) var233)
(declare-fun var2761_getDescriptor/-341840832 () var1795)
(declare-fun hashCode/1739917532 (var2032) Int)
(declare-fun cast-from-var1795-to-var2032 (var1795) var2032)
(declare-fun getService/-1311689935 (var2761) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getUnknownFields/94315221 (var233) var1791)
(declare-fun hashCode/247890256 (var1791) Int)
(declare-const null-var2761 var2761)
(declare-const var1319 var2761) ; Statement: r0 := @this: io.grpc.health.v1.HealthCheckRequest 
(assert (not (= var1319 null-var2761)))
(define-const var2454 Int (memoizedHashCode/623481040 (cast-from-var2761-to-var233 var1319))) ; Statement: $i0 = r0.<io.grpc.health.v1.HealthCheckRequest: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <io.grpc.health.v1.HealthCheckRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var2454 0)) ; Cond: $i0 == 0 
(define-const var2559 var1795 var2761_getDescriptor/-341840832) ; Statement: $r1 = staticinvoke <io.grpc.health.v1.HealthCheckRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var1649 Int (hashCode/1739917532 (cast-from-var1795-to-var2032 var2559))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var3495 Int (+ 779 var1649)) ; Statement: i8 = 779 + $i1 
(define-const var3410 Int (* 37 var3495)) ; Statement: $i2 = 37 * i8 
(define-const var845 Int (+ var3410 1)) ; Statement: i9 = $i2 + 1 
(define-const var1476 Int (* 53 var845)) ; Statement: $i4 = 53 * i9 
(assert true)
(define-const var3070 String (getService/-1311689935 var1319)) ; Statement: $r2 = virtualinvoke r0.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>() 
(assert true)
(define-const var1417 Int (hashCode/-467973558 var3070)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3116 Int (+ var1476 var1417)) ; Statement: i10 = $i4 + $i3 
(define-const var14 Int (* 29 var3116)) ; Statement: $i6 = 29 * i10 
(assert true)
(define-const var1971 var1791 (getUnknownFields/94315221 (cast-from-var2761-to-var233 var1319))) ; Statement: $r3 = virtualinvoke r0.<io.grpc.health.v1.HealthCheckRequest: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var2641 Int (hashCode/247890256 var1971)) ; Statement: $i5 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var6 Int (+ var14 var2641)) ; Statement: i11 = $i6 + $i5 
(declare-const var1319!1 var2761)
(assert (not (= var1319!1 null-var2761)))
(assert (= (memoizedHashCode/623481040 (cast-from-var2761-to-var233 var1319!1)) var6)) ; Statement: r0.<io.grpc.health.v1.HealthCheckRequest: int memoizedHashCode> = i11 
 ; Statement: return i11 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var2761-to-var233=([io.grpc.health.v1.HealthCheckRequest], com.google.protobuf.GeneratedMessageV3), var2761_getDescriptor/-341840832=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var1795-to-var2032=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getService/-1311689935=([io.grpc.health.v1.HealthCheckRequest], java.lang.String), hashCode/-467973558=([java.lang.String], int), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var2761=io.grpc.health.v1.HealthCheckRequest, var1319=r0, var233=com.google.protobuf.GeneratedMessageV3, var2454=$i0, var1795=com.google.protobuf.Descriptors$Descriptor, var2559=$r1, var2032=java.lang.Object, var1649=$i1, var3495=i8, var3410=$i2, var845=i9, var1476=$i4, var3070=$r2, var1417=$i3, var3116=i10, var14=$i6, var1791=com.google.protobuf.UnknownFieldSet, var1971=$r3, var2641=$i5, var6=i11}
; {io.grpc.health.v1.HealthCheckRequest=var2761, r0=var1319, com.google.protobuf.GeneratedMessageV3=var233, $i0=var2454, com.google.protobuf.Descriptors$Descriptor=var1795, $r1=var2559, java.lang.Object=var2032, $i1=var1649, i8=var3495, $i2=var3410, i9=var845, $i4=var1476, $r2=var3070, $i3=var1417, i10=var3116, $i6=var14, com.google.protobuf.UnknownFieldSet=var1791, $r3=var1971, $i5=var2641, i11=var6}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: io.grpc.health.v1.HealthCheckRequest;	$i0 = r0.<io.grpc.health.v1.HealthCheckRequest: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <io.grpc.health.v1.HealthCheckRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <io.grpc.health.v1.HealthCheckRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i8 = 779 + $i1;	$i2 = 37 * i8;	i9 = $i2 + 1;	$i4 = 53 * i9;	$r2 = virtualinvoke r0.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i10 = $i4 + $i3;	$i6 = 29 * i10;	$r3 = virtualinvoke r0.<io.grpc.health.v1.HealthCheckRequest: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i5 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i11 = $i6 + $i5;	r0.<io.grpc.health.v1.HealthCheckRequest: int memoizedHashCode> = i11;	return i11
;block_num 2