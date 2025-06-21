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

(declare-sort var365 0)
(declare-sort var3315 0)
(declare-sort var1315 0)
(declare-sort var2629 0)
(declare-sort var1622 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var3315) Int)
(declare-fun cast-from-var365-to-var3315 (var365) var3315)
(declare-fun var365_getDescriptor/1743977949 () var1315)
(declare-fun hashCode/1739917532 (var2629) Int)
(declare-fun cast-from-var1315-to-var2629 (var1315) var2629)
(declare-fun getRevision/973979446 (var365) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getUnknownFields/94315221 (var3315) var1622)
(declare-fun hashCode/247890256 (var1622) Int)
(declare-const null-var365 var365)
(declare-const var235 var365) ; Statement: r0 := @this: org.apache.dubbo.metadata.MetadataRequest 
(assert (not (= var235 null-var365)))
(define-const var3658 Int (memoizedHashCode/623481040 (cast-from-var365-to-var3315 var235))) ; Statement: $i0 = r0.<org.apache.dubbo.metadata.MetadataRequest: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.metadata.MetadataRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var3658 0)) ; Cond: $i0 == 0 
(define-const var2177 var1315 var365_getDescriptor/1743977949) ; Statement: $r1 = staticinvoke <org.apache.dubbo.metadata.MetadataRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var927 Int (hashCode/1739917532 (cast-from-var1315-to-var2629 var2177))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var3789 Int (+ 779 var927)) ; Statement: i8 = 779 + $i1 
(define-const var1696 Int (* 37 var3789)) ; Statement: $i2 = 37 * i8 
(define-const var3228 Int (+ var1696 1)) ; Statement: i9 = $i2 + 1 
(define-const var240 Int (* 53 var3228)) ; Statement: $i4 = 53 * i9 
(assert true)
(define-const var480 String (getRevision/973979446 var235)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataRequest: java.lang.String getRevision()>() 
(assert true)
(define-const var2813 Int (hashCode/-467973558 var480)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var2416 Int (+ var240 var2813)) ; Statement: i10 = $i4 + $i3 
(define-const var292 Int (* 29 var2416)) ; Statement: $i6 = 29 * i10 
(assert true)
(define-const var456 var1622 (getUnknownFields/94315221 (cast-from-var365-to-var3315 var235))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataRequest: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var3534 Int (hashCode/247890256 var456)) ; Statement: $i5 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var384 Int (+ var292 var3534)) ; Statement: i11 = $i6 + $i5 
(declare-const var235!1 var365)
(assert (not (= var235!1 null-var365)))
(assert (= (memoizedHashCode/623481040 (cast-from-var365-to-var3315 var235!1)) var384)) ; Statement: r0.<org.apache.dubbo.metadata.MetadataRequest: int memoizedHashCode> = i11 
 ; Statement: return i11 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var365-to-var3315=([org.apache.dubbo.metadata.MetadataRequest], com.google.protobuf.GeneratedMessageV3), var365_getDescriptor/1743977949=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var1315-to-var2629=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getRevision/973979446=([org.apache.dubbo.metadata.MetadataRequest], java.lang.String), hashCode/-467973558=([java.lang.String], int), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var365=org.apache.dubbo.metadata.MetadataRequest, var235=r0, var3315=com.google.protobuf.GeneratedMessageV3, var3658=$i0, var1315=com.google.protobuf.Descriptors$Descriptor, var2177=$r1, var2629=java.lang.Object, var927=$i1, var3789=i8, var1696=$i2, var3228=i9, var240=$i4, var480=$r2, var2813=$i3, var2416=i10, var292=$i6, var1622=com.google.protobuf.UnknownFieldSet, var456=$r3, var3534=$i5, var384=i11}
; {org.apache.dubbo.metadata.MetadataRequest=var365, r0=var235, com.google.protobuf.GeneratedMessageV3=var3315, $i0=var3658, com.google.protobuf.Descriptors$Descriptor=var1315, $r1=var2177, java.lang.Object=var2629, $i1=var927, i8=var3789, $i2=var1696, i9=var3228, $i4=var240, $r2=var480, $i3=var2813, i10=var2416, $i6=var292, com.google.protobuf.UnknownFieldSet=var1622, $r3=var456, $i5=var3534, i11=var384}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.MetadataRequest;	$i0 = r0.<org.apache.dubbo.metadata.MetadataRequest: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.metadata.MetadataRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <org.apache.dubbo.metadata.MetadataRequest: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i8 = 779 + $i1;	$i2 = 37 * i8;	i9 = $i2 + 1;	$i4 = 53 * i9;	$r2 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataRequest: java.lang.String getRevision()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i10 = $i4 + $i3;	$i6 = 29 * i10;	$r3 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataRequest: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i5 = virtualinvoke $r3.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i11 = $i6 + $i5;	r0.<org.apache.dubbo.metadata.MetadataRequest: int memoizedHashCode> = i11;	return i11
;block_num 2