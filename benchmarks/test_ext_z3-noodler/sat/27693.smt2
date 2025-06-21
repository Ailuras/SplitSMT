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

(declare-sort var2360 0)
(declare-sort var3054 0)
(declare-sort var2196 0)
(declare-sort var3936 0)
(declare-sort var2445 0)
(declare-sort var2512 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var3054) Int)
(declare-fun cast-from-var2360-to-var3054 (var2360) var3054)
(declare-fun var2360_getDescriptor/1362048241 () var2196)
(declare-fun hashCode/1739917532 (var3936) Int)
(declare-fun cast-from-var2196-to-var3936 (var2196) var3936)
(declare-fun getLanguage/1653781421 (var2360) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getSerialization/-928266299 (var2360) String)
(declare-fun getClassName/-716590414 (var2360) String)
(declare-fun getData/-1081454356 (var2360) var2445)
(declare-fun hashCode/-1417641317 (var2445) Int)
(declare-fun getUnknownFields/94315221 (var3054) var2512)
(declare-fun hashCode/247890256 (var2512) Int)
(declare-const null-var2360 var2360)
(declare-const var3956 var2360) ; Statement: r0 := @this: org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper 
(assert (not (= var3956 null-var2360)))
(define-const var3180 Int (memoizedHashCode/623481040 (cast-from-var2360-to-var3054 var3956))) ; Statement: $i0 = r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var3180 0)) ; Cond: $i0 == 0 
(define-const var3789 var2196 var2360_getDescriptor/1362048241) ; Statement: $r1 = staticinvoke <org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var644 Int (hashCode/1739917532 (cast-from-var2196-to-var3936 var3789))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var3614 Int (+ 779 var644)) ; Statement: i17 = 779 + $i1 
(define-const var1490 Int (* 37 var3614)) ; Statement: $i2 = 37 * i17 
(define-const var3829 Int (+ var1490 1)) ; Statement: i18 = $i2 + 1 
(define-const var2817 Int (* 53 var3829)) ; Statement: $i4 = 53 * i18 
(assert true)
(define-const var3365 String (getLanguage/1653781421 var3956)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: java.lang.String getLanguage()>() 
(assert true)
(define-const var3552 Int (hashCode/-467973558 var3365)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var197 Int (+ var2817 var3552)) ; Statement: i19 = $i4 + $i3 
(define-const var2233 Int (* 37 var197)) ; Statement: $i5 = 37 * i19 
(define-const var1749 Int (+ var2233 2)) ; Statement: i20 = $i5 + 2 
(define-const var2162 Int (* 53 var1749)) ; Statement: $i7 = 53 * i20 
(assert true)
(define-const var3112 String (getSerialization/-928266299 var3956)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: java.lang.String getSerialization()>() 
(assert true)
(define-const var1158 Int (hashCode/-467973558 var3112)) ; Statement: $i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var1711 Int (+ var2162 var1158)) ; Statement: i21 = $i7 + $i6 
(define-const var3866 Int (* 37 var1711)) ; Statement: $i8 = 37 * i21 
(define-const var2619 Int (+ var3866 3)) ; Statement: i22 = $i8 + 3 
(define-const var827 Int (* 53 var2619)) ; Statement: $i10 = 53 * i22 
(assert true)
(define-const var71 String (getClassName/-716590414 var3956)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: java.lang.String getClassName()>() 
(assert true)
(define-const var1723 Int (hashCode/-467973558 var71)) ; Statement: $i9 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(define-const var662 Int (+ var827 var1723)) ; Statement: i23 = $i10 + $i9 
(define-const var205 Int (* 37 var662)) ; Statement: $i11 = 37 * i23 
(define-const var905 Int (+ var205 4)) ; Statement: i24 = $i11 + 4 
(define-const var701 Int (* 53 var905)) ; Statement: $i13 = 53 * i24 
(assert true)
(define-const var1492 var2445 (getData/-1081454356 var3956)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: com.google.protobuf.ByteString getData()>() 
(assert true)
(define-const var97 Int (hashCode/-1417641317 var1492)) ; Statement: $i12 = virtualinvoke $r5.<com.google.protobuf.ByteString: int hashCode()>() 
(define-const var3479 Int (+ var701 var97)) ; Statement: i25 = $i13 + $i12 
(define-const var150 Int (* 29 var3479)) ; Statement: $i15 = 29 * i25 
(assert true)
(define-const var187 var2512 (getUnknownFields/94315221 (cast-from-var2360-to-var3054 var3956))) ; Statement: $r6 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var1327 Int (hashCode/247890256 var187)) ; Statement: $i14 = virtualinvoke $r6.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var1160 Int (+ var150 var1327)) ; Statement: i26 = $i15 + $i14 
(declare-const var3956!1 var2360)
(assert (not (= var3956!1 null-var2360)))
(assert (= (memoizedHashCode/623481040 (cast-from-var2360-to-var3054 var3956!1)) var1160)) ; Statement: r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: int memoizedHashCode> = i26 
 ; Statement: return i26 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var2360-to-var3054=([org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper], com.google.protobuf.GeneratedMessageV3), var2360_getDescriptor/1362048241=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var2196-to-var3936=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getLanguage/1653781421=([org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper], java.lang.String), hashCode/-467973558=([java.lang.String], int), getSerialization/-928266299=([org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper], java.lang.String), getClassName/-716590414=([org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper], java.lang.String), getData/-1081454356=([org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper], com.google.protobuf.ByteString), hashCode/-1417641317=([com.google.protobuf.ByteString], int), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var2360=org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper, var3956=r0, var3054=com.google.protobuf.GeneratedMessageV3, var3180=$i0, var2196=com.google.protobuf.Descriptors$Descriptor, var3789=$r1, var3936=java.lang.Object, var644=$i1, var3614=i17, var1490=$i2, var3829=i18, var2817=$i4, var3365=$r2, var3552=$i3, var197=i19, var2233=$i5, var1749=i20, var2162=$i7, var3112=$r3, var1158=$i6, var1711=i21, var3866=$i8, var2619=i22, var827=$i10, var71=$r4, var1723=$i9, var662=i23, var205=$i11, var905=i24, var701=$i13, var2445=com.google.protobuf.ByteString, var1492=$r5, var97=$i12, var3479=i25, var150=$i15, var2512=com.google.protobuf.UnknownFieldSet, var187=$r6, var1327=$i14, var1160=i26}
; {org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper=var2360, r0=var3956, com.google.protobuf.GeneratedMessageV3=var3054, $i0=var3180, com.google.protobuf.Descriptors$Descriptor=var2196, $r1=var3789, java.lang.Object=var3936, $i1=var644, i17=var3614, $i2=var1490, i18=var3829, $i4=var2817, $r2=var3365, $i3=var3552, i19=var197, $i5=var2233, i20=var1749, $i7=var2162, $r3=var3112, $i6=var1158, i21=var1711, $i8=var3866, i22=var2619, $i10=var827, $r4=var71, $i9=var1723, i23=var662, $i11=var205, i24=var905, $i13=var701, com.google.protobuf.ByteString=var2445, $r5=var1492, $i12=var97, i25=var3479, $i15=var150, com.google.protobuf.UnknownFieldSet=var2512, $r6=var187, $i14=var1327, i26=var1160}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 3}
;stmts r0 := @this: org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper;	$i0 = r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i17 = 779 + $i1;	$i2 = 37 * i17;	i18 = $i2 + 1;	$i4 = 53 * i18;	$r2 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: java.lang.String getLanguage()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i19 = $i4 + $i3;	$i5 = 37 * i19;	i20 = $i5 + 2;	$i7 = 53 * i20;	$r3 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: java.lang.String getSerialization()>();	$i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	i21 = $i7 + $i6;	$i8 = 37 * i21;	i22 = $i8 + 3;	$i10 = 53 * i22;	$r4 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: java.lang.String getClassName()>();	$i9 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	i23 = $i10 + $i9;	$i11 = 37 * i23;	i24 = $i11 + 4;	$i13 = 53 * i24;	$r5 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: com.google.protobuf.ByteString getData()>();	$i12 = virtualinvoke $r5.<com.google.protobuf.ByteString: int hashCode()>();	i25 = $i13 + $i12;	$i15 = 29 * i25;	$r6 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i14 = virtualinvoke $r6.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i26 = $i15 + $i14;	r0.<org.apache.dubbo.triple.TripleWrapper$TripleExceptionWrapper: int memoizedHashCode> = i26;	return i26
;block_num 2