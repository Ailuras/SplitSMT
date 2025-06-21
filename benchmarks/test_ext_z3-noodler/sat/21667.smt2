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

(declare-sort var3797 0)
(declare-sort var3423 0)
(declare-sort var3350 0)
(declare-sort var1349 0)
(declare-sort var2506 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var3423) Int)
(declare-fun cast-from-var3797-to-var3423 (var3797) var3423)
(declare-fun var3797_getDescriptor/-1662534121 () var3350)
(declare-fun hashCode/1739917532 (var1349) Int)
(declare-fun cast-from-var3350-to-var1349 (var3350) var1349)
(declare-fun getResourceType/1065411523 (var3797) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getResourceName/-654513454 (var3797) String)
(declare-fun getOwner/427360700 (var3797) String)
(declare-fun getDescription/-203931053 (var3797) String)
(declare-fun getUnknownFields/94315221 (var3423) var2506)
(declare-fun hashCode/247890256 (var2506) Int)
(declare-const null-var3797 var3797)
(declare-const var648 var3797) ; Statement: r0 := @this: com.google.rpc.ResourceInfo 
(assert (not (= var648 null-var3797)))
(define-const var3306 Int (memoizedHashCode/623481040 (cast-from-var3797-to-var3423 var648))) ; Statement: $i0 = r0.<com.google.rpc.ResourceInfo: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.ResourceInfo: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var3306 0)) ; Cond: $i0 == 0 
(define-const var3097 var3350 var3797_getDescriptor/-1662534121) ; Statement: $r1 = staticinvoke <com.google.rpc.ResourceInfo: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var2021 Int (hashCode/1739917532 (cast-from-var3350-to-var1349 var3097))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var3483 Int (+ 779 var2021)) ; Statement: i17 = 779 + $i1 
(define-const var2074 Int (* 37 var3483)) ; Statement: $i2 = 37 * i17 
(define-const var42 Int (+ var2074 1)) ; Statement: i18 = $i2 + 1 
(define-const var3542 Int (* 53 var42)) ; Statement: $i4 = 53 * i18 
(assert true)
(define-const var2644 String (getResourceType/1065411523 var648)) ; Statement: $r2 = virtualinvoke r0.<com.google.rpc.ResourceInfo: java.lang.String getResourceType()>() 
(assert true)
(define-const var639 Int (hashCode/-467973558 var2644)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3966 Int (+ var3542 var639)) ; Statement: i19 = $i4 + $i3 
(define-const var2829 Int (* 37 var3966)) ; Statement: $i5 = 37 * i19 
(define-const var1630 Int (+ var2829 2)) ; Statement: i20 = $i5 + 2 
(define-const var3605 Int (* 53 var1630)) ; Statement: $i7 = 53 * i20 
(assert true)
(define-const var2394 String (getResourceName/-654513454 var648)) ; Statement: $r3 = virtualinvoke r0.<com.google.rpc.ResourceInfo: java.lang.String getResourceName()>() 
(assert true)
(define-const var3890 Int (hashCode/-467973558 var2394)) ; Statement: $i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var693 Int (+ var3605 var3890)) ; Statement: i21 = $i7 + $i6 
(define-const var2406 Int (* 37 var693)) ; Statement: $i8 = 37 * i21 
(define-const var1589 Int (+ var2406 3)) ; Statement: i22 = $i8 + 3 
(define-const var2784 Int (* 53 var1589)) ; Statement: $i10 = 53 * i22 
(assert true)
(define-const var3040 String (getOwner/427360700 var648)) ; Statement: $r4 = virtualinvoke r0.<com.google.rpc.ResourceInfo: java.lang.String getOwner()>() 
(assert true)
(define-const var3819 Int (hashCode/-467973558 var3040)) ; Statement: $i9 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(define-const var1181 Int (+ var2784 var3819)) ; Statement: i23 = $i10 + $i9 
(define-const var778 Int (* 37 var1181)) ; Statement: $i11 = 37 * i23 
(define-const var3812 Int (+ var778 4)) ; Statement: i24 = $i11 + 4 
(define-const var2049 Int (* 53 var3812)) ; Statement: $i13 = 53 * i24 
(assert true)
(define-const var2678 String (getDescription/-203931053 var648)) ; Statement: $r5 = virtualinvoke r0.<com.google.rpc.ResourceInfo: java.lang.String getDescription()>() 
(assert true)
(define-const var3476 Int (hashCode/-467973558 var2678)) ; Statement: $i12 = virtualinvoke $r5.<java.lang.String: int hashCode()>() 
(define-const var3420 Int (+ var2049 var3476)) ; Statement: i25 = $i13 + $i12 
(define-const var3622 Int (* 29 var3420)) ; Statement: $i15 = 29 * i25 
(assert true)
(define-const var2845 var2506 (getUnknownFields/94315221 (cast-from-var3797-to-var3423 var648))) ; Statement: $r6 = virtualinvoke r0.<com.google.rpc.ResourceInfo: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var2135 Int (hashCode/247890256 var2845)) ; Statement: $i14 = virtualinvoke $r6.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var3735 Int (+ var3622 var2135)) ; Statement: i26 = $i15 + $i14 
(declare-const var648!1 var3797)
(assert (not (= var648!1 null-var3797)))
(assert (= (memoizedHashCode/623481040 (cast-from-var3797-to-var3423 var648!1)) var3735)) ; Statement: r0.<com.google.rpc.ResourceInfo: int memoizedHashCode> = i26 
 ; Statement: return i26 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var3797-to-var3423=([com.google.rpc.ResourceInfo], com.google.protobuf.GeneratedMessageV3), var3797_getDescriptor/-1662534121=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var3350-to-var1349=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getResourceType/1065411523=([com.google.rpc.ResourceInfo], java.lang.String), hashCode/-467973558=([java.lang.String], int), getResourceName/-654513454=([com.google.rpc.ResourceInfo], java.lang.String), getOwner/427360700=([com.google.rpc.ResourceInfo], java.lang.String), getDescription/-203931053=([com.google.rpc.ResourceInfo], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var3797=com.google.rpc.ResourceInfo, var648=r0, var3423=com.google.protobuf.GeneratedMessageV3, var3306=$i0, var3350=com.google.protobuf.Descriptors$Descriptor, var3097=$r1, var1349=java.lang.Object, var2021=$i1, var3483=i17, var2074=$i2, var42=i18, var3542=$i4, var2644=$r2, var639=$i3, var3966=i19, var2829=$i5, var1630=i20, var3605=$i7, var2394=$r3, var3890=$i6, var693=i21, var2406=$i8, var1589=i22, var2784=$i10, var3040=$r4, var3819=$i9, var1181=i23, var778=$i11, var3812=i24, var2049=$i13, var2678=$r5, var3476=$i12, var3420=i25, var3622=$i15, var2506=com.google.protobuf.UnknownFieldSet, var2845=$r6, var2135=$i14, var3735=i26}
; {com.google.rpc.ResourceInfo=var3797, r0=var648, com.google.protobuf.GeneratedMessageV3=var3423, $i0=var3306, com.google.protobuf.Descriptors$Descriptor=var3350, $r1=var3097, java.lang.Object=var1349, $i1=var2021, i17=var3483, $i2=var2074, i18=var42, $i4=var3542, $r2=var2644, $i3=var639, i19=var3966, $i5=var2829, i20=var1630, $i7=var3605, $r3=var2394, $i6=var3890, i21=var693, $i8=var2406, i22=var1589, $i10=var2784, $r4=var3040, $i9=var3819, i23=var1181, $i11=var778, i24=var3812, $i13=var2049, $r5=var2678, $i12=var3476, i25=var3420, $i15=var3622, com.google.protobuf.UnknownFieldSet=var2506, $r6=var2845, $i14=var2135, i26=var3735}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 4}
;stmts r0 := @this: com.google.rpc.ResourceInfo;	$i0 = r0.<com.google.rpc.ResourceInfo: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.ResourceInfo: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <com.google.rpc.ResourceInfo: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i17 = 779 + $i1;	$i2 = 37 * i17;	i18 = $i2 + 1;	$i4 = 53 * i18;	$r2 = virtualinvoke r0.<com.google.rpc.ResourceInfo: java.lang.String getResourceType()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i19 = $i4 + $i3;	$i5 = 37 * i19;	i20 = $i5 + 2;	$i7 = 53 * i20;	$r3 = virtualinvoke r0.<com.google.rpc.ResourceInfo: java.lang.String getResourceName()>();	$i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	i21 = $i7 + $i6;	$i8 = 37 * i21;	i22 = $i8 + 3;	$i10 = 53 * i22;	$r4 = virtualinvoke r0.<com.google.rpc.ResourceInfo: java.lang.String getOwner()>();	$i9 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	i23 = $i10 + $i9;	$i11 = 37 * i23;	i24 = $i11 + 4;	$i13 = 53 * i24;	$r5 = virtualinvoke r0.<com.google.rpc.ResourceInfo: java.lang.String getDescription()>();	$i12 = virtualinvoke $r5.<java.lang.String: int hashCode()>();	i25 = $i13 + $i12;	$i15 = 29 * i25;	$r6 = virtualinvoke r0.<com.google.rpc.ResourceInfo: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i14 = virtualinvoke $r6.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i26 = $i15 + $i14;	r0.<com.google.rpc.ResourceInfo: int memoizedHashCode> = i26;	return i26
;block_num 2