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

(declare-sort var1248 0)
(declare-sort var450 0)
(declare-sort var1009 0)
(declare-sort var3904 0)
(declare-sort var529 0)
(declare-sort var259 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var450) Int)
(declare-fun cast-from-var1248-to-var450 (var1248) var450)
(declare-fun var1248_getDescriptor/691590761 () var1009)
(declare-fun hashCode/1739917532 (var3904) Int)
(declare-fun cast-from-var1009-to-var3904 (var1009) var3904)
(declare-fun getSerializeType/1419854531 (var1248) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getData/1968955492 (var1248) var529)
(declare-fun hashCode/-1417641317 (var529) Int)
(declare-fun getType/-1686328829 (var1248) String)
(declare-fun getUnknownFields/94315221 (var450) var259)
(declare-fun hashCode/247890256 (var259) Int)
(declare-const null-var1248 var1248)
(declare-const var3931 var1248) ; Statement: r0 := @this: org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper 
(assert (not (= var3931 null-var1248)))
(define-const var1222 Int (memoizedHashCode/623481040 (cast-from-var1248-to-var450 var3931))) ; Statement: $i0 = r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var1222 0)) ; Cond: $i0 == 0 
(define-const var3329 var1009 var1248_getDescriptor/691590761) ; Statement: $r1 = staticinvoke <org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var426 Int (hashCode/1739917532 (cast-from-var1009-to-var3904 var3329))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var2057 Int (+ 779 var426)) ; Statement: i14 = 779 + $i1 
(define-const var410 Int (* 37 var2057)) ; Statement: $i2 = 37 * i14 
(define-const var3153 Int (+ var410 1)) ; Statement: i15 = $i2 + 1 
(define-const var2473 Int (* 53 var3153)) ; Statement: $i4 = 53 * i15 
(assert true)
(define-const var982 String (getSerializeType/1419854531 var3931)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: java.lang.String getSerializeType()>() 
(assert true)
(define-const var2681 Int (hashCode/-467973558 var982)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3340 Int (+ var2473 var2681)) ; Statement: i16 = $i4 + $i3 
(define-const var1358 Int (* 37 var3340)) ; Statement: $i5 = 37 * i16 
(define-const var745 Int (+ var1358 2)) ; Statement: i17 = $i5 + 2 
(define-const var1895 Int (* 53 var745)) ; Statement: $i7 = 53 * i17 
(assert true)
(define-const var435 var529 (getData/1968955492 var3931)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: com.google.protobuf.ByteString getData()>() 
(assert true)
(define-const var1989 Int (hashCode/-1417641317 var435)) ; Statement: $i6 = virtualinvoke $r3.<com.google.protobuf.ByteString: int hashCode()>() 
(define-const var1685 Int (+ var1895 var1989)) ; Statement: i18 = $i7 + $i6 
(define-const var3427 Int (* 37 var1685)) ; Statement: $i8 = 37 * i18 
(define-const var2772 Int (+ var3427 3)) ; Statement: i19 = $i8 + 3 
(define-const var104 Int (* 53 var2772)) ; Statement: $i10 = 53 * i19 
(assert true)
(define-const var3608 String (getType/-1686328829 var3931)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: java.lang.String getType()>() 
(assert true)
(define-const var2545 Int (hashCode/-467973558 var3608)) ; Statement: $i9 = virtualinvoke $r4.<java.lang.String: int hashCode()>() 
(define-const var2746 Int (+ var104 var2545)) ; Statement: i20 = $i10 + $i9 
(define-const var474 Int (* 29 var2746)) ; Statement: $i12 = 29 * i20 
(assert true)
(define-const var269 var259 (getUnknownFields/94315221 (cast-from-var1248-to-var450 var3931))) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var1058 Int (hashCode/247890256 var269)) ; Statement: $i11 = virtualinvoke $r5.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var2458 Int (+ var474 var1058)) ; Statement: i21 = $i12 + $i11 
(declare-const var3931!1 var1248)
(assert (not (= var3931!1 null-var1248)))
(assert (= (memoizedHashCode/623481040 (cast-from-var1248-to-var450 var3931!1)) var2458)) ; Statement: r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: int memoizedHashCode> = i21 
 ; Statement: return i21 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var1248-to-var450=([org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper], com.google.protobuf.GeneratedMessageV3), var1248_getDescriptor/691590761=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var1009-to-var3904=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getSerializeType/1419854531=([org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper], java.lang.String), hashCode/-467973558=([java.lang.String], int), getData/1968955492=([org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper], com.google.protobuf.ByteString), hashCode/-1417641317=([com.google.protobuf.ByteString], int), getType/-1686328829=([org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var1248=org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper, var3931=r0, var450=com.google.protobuf.GeneratedMessageV3, var1222=$i0, var1009=com.google.protobuf.Descriptors$Descriptor, var3329=$r1, var3904=java.lang.Object, var426=$i1, var2057=i14, var410=$i2, var3153=i15, var2473=$i4, var982=$r2, var2681=$i3, var3340=i16, var1358=$i5, var745=i17, var1895=$i7, var529=com.google.protobuf.ByteString, var435=$r3, var1989=$i6, var1685=i18, var3427=$i8, var2772=i19, var104=$i10, var3608=$r4, var2545=$i9, var2746=i20, var474=$i12, var259=com.google.protobuf.UnknownFieldSet, var269=$r5, var1058=$i11, var2458=i21}
; {org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper=var1248, r0=var3931, com.google.protobuf.GeneratedMessageV3=var450, $i0=var1222, com.google.protobuf.Descriptors$Descriptor=var1009, $r1=var3329, java.lang.Object=var3904, $i1=var426, i14=var2057, $i2=var410, i15=var3153, $i4=var2473, $r2=var982, $i3=var2681, i16=var3340, $i5=var1358, i17=var745, $i7=var1895, com.google.protobuf.ByteString=var529, $r3=var435, $i6=var1989, i18=var1685, $i8=var3427, i19=var2772, $i10=var104, $r4=var3608, $i9=var2545, i20=var2746, $i12=var474, com.google.protobuf.UnknownFieldSet=var259, $r5=var269, $i11=var1058, i21=var2458}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper;	$i0 = r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i14 = 779 + $i1;	$i2 = 37 * i14;	i15 = $i2 + 1;	$i4 = 53 * i15;	$r2 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: java.lang.String getSerializeType()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i16 = $i4 + $i3;	$i5 = 37 * i16;	i17 = $i5 + 2;	$i7 = 53 * i17;	$r3 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: com.google.protobuf.ByteString getData()>();	$i6 = virtualinvoke $r3.<com.google.protobuf.ByteString: int hashCode()>();	i18 = $i7 + $i6;	$i8 = 37 * i18;	i19 = $i8 + 3;	$i10 = 53 * i19;	$r4 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: java.lang.String getType()>();	$i9 = virtualinvoke $r4.<java.lang.String: int hashCode()>();	i20 = $i10 + $i9;	$i12 = 29 * i20;	$r5 = virtualinvoke r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i11 = virtualinvoke $r5.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i21 = $i12 + $i11;	r0.<org.apache.dubbo.triple.TripleWrapper$TripleResponseWrapper: int memoizedHashCode> = i21;	return i21
;block_num 2