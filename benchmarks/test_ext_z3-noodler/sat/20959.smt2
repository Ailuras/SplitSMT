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

(declare-sort var1719 0)
(declare-sort var2953 0)
(declare-sort var3084 0)
(declare-sort var551 0)
(declare-sort var1576 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun memoizedHashCode/623481040 (var2953) Int)
(declare-fun cast-from-var1719-to-var2953 (var1719) var2953)
(declare-fun var1719_getDescriptor/1660764800 () var3084)
(declare-fun hashCode/1739917532 (var551) Int)
(declare-fun cast-from-var3084-to-var551 (var3084) var551)
(declare-fun getDescription/1595228618 (var1719) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun getUrl/-1024155529 (var1719) String)
(declare-fun getUnknownFields/94315221 (var2953) var1576)
(declare-fun hashCode/247890256 (var1576) Int)
(declare-const null-var1719 var1719)
(declare-const var2514 var1719) ; Statement: r0 := @this: com.google.rpc.Help$Link 
(assert (not (= var2514 null-var1719)))
(define-const var1476 Int (memoizedHashCode/623481040 (cast-from-var1719-to-var2953 var2514))) ; Statement: $i0 = r0.<com.google.rpc.Help$Link: int memoizedHashCode> 
 ; Statement: if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.Help$Link: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert (= var1476 0)) ; Cond: $i0 == 0 
(define-const var994 var3084 var1719_getDescriptor/1660764800) ; Statement: $r1 = staticinvoke <com.google.rpc.Help$Link: com.google.protobuf.Descriptors$Descriptor getDescriptor()>() 
(assert true)
(define-const var3920 Int (hashCode/1739917532 (cast-from-var3084-to-var551 var994))) ; Statement: $i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>() 
(define-const var2494 Int (+ 779 var3920)) ; Statement: i11 = 779 + $i1 
(define-const var1668 Int (* 37 var2494)) ; Statement: $i2 = 37 * i11 
(define-const var3253 Int (+ var1668 1)) ; Statement: i12 = $i2 + 1 
(define-const var3414 Int (* 53 var3253)) ; Statement: $i4 = 53 * i12 
(assert true)
(define-const var2107 String (getDescription/1595228618 var2514)) ; Statement: $r2 = virtualinvoke r0.<com.google.rpc.Help$Link: java.lang.String getDescription()>() 
(assert true)
(define-const var3925 Int (hashCode/-467973558 var2107)) ; Statement: $i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var408 Int (+ var3414 var3925)) ; Statement: i13 = $i4 + $i3 
(define-const var1136 Int (* 37 var408)) ; Statement: $i5 = 37 * i13 
(define-const var3911 Int (+ var1136 2)) ; Statement: i14 = $i5 + 2 
(define-const var260 Int (* 53 var3911)) ; Statement: $i7 = 53 * i14 
(assert true)
(define-const var77 String (getUrl/-1024155529 var2514)) ; Statement: $r3 = virtualinvoke r0.<com.google.rpc.Help$Link: java.lang.String getUrl()>() 
(assert true)
(define-const var853 Int (hashCode/-467973558 var77)) ; Statement: $i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var3791 Int (+ var260 var853)) ; Statement: i15 = $i7 + $i6 
(define-const var986 Int (* 29 var3791)) ; Statement: $i9 = 29 * i15 
(assert true)
(define-const var3355 var1576 (getUnknownFields/94315221 (cast-from-var1719-to-var2953 var2514))) ; Statement: $r4 = virtualinvoke r0.<com.google.rpc.Help$Link: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
(define-const var554 Int (hashCode/247890256 var3355)) ; Statement: $i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>() 
(define-const var2150 Int (+ var986 var554)) ; Statement: i16 = $i9 + $i8 
(declare-const var2514!1 var1719)
(assert (not (= var2514!1 null-var1719)))
(assert (= (memoizedHashCode/623481040 (cast-from-var1719-to-var2953 var2514!1)) var2150)) ; Statement: r0.<com.google.rpc.Help$Link: int memoizedHashCode> = i16 
 ; Statement: return i16 
(check-sat)
; {memoizedHashCode/623481040=([com.google.protobuf.GeneratedMessageV3], int), cast-from-var1719-to-var2953=([com.google.rpc.Help$Link], com.google.protobuf.GeneratedMessageV3), var1719_getDescriptor/1660764800=([], com.google.protobuf.Descriptors$Descriptor), hashCode/1739917532=([java.lang.Object], int), cast-from-var3084-to-var551=([com.google.protobuf.Descriptors$Descriptor], java.lang.Object), getDescription/1595228618=([com.google.rpc.Help$Link], java.lang.String), hashCode/-467973558=([java.lang.String], int), getUrl/-1024155529=([com.google.rpc.Help$Link], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), hashCode/247890256=([com.google.protobuf.UnknownFieldSet], int)}
; {var1719=com.google.rpc.Help$Link, var2514=r0, var2953=com.google.protobuf.GeneratedMessageV3, var1476=$i0, var3084=com.google.protobuf.Descriptors$Descriptor, var994=$r1, var551=java.lang.Object, var3920=$i1, var2494=i11, var1668=$i2, var3253=i12, var3414=$i4, var2107=$r2, var3925=$i3, var408=i13, var1136=$i5, var3911=i14, var260=$i7, var77=$r3, var853=$i6, var3791=i15, var986=$i9, var1576=com.google.protobuf.UnknownFieldSet, var3355=$r4, var554=$i8, var2150=i16}
; {com.google.rpc.Help$Link=var1719, r0=var2514, com.google.protobuf.GeneratedMessageV3=var2953, $i0=var1476, com.google.protobuf.Descriptors$Descriptor=var3084, $r1=var994, java.lang.Object=var551, $i1=var3920, i11=var2494, $i2=var1668, i12=var3253, $i4=var3414, $r2=var2107, $i3=var3925, i13=var408, $i5=var1136, i14=var3911, $i7=var260, $r3=var77, $i6=var853, i15=var3791, $i9=var986, com.google.protobuf.UnknownFieldSet=var1576, $r4=var3355, $i8=var554, i16=var2150}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 2}
;stmts r0 := @this: com.google.rpc.Help$Link;	$i0 = r0.<com.google.rpc.Help$Link: int memoizedHashCode>;	if $i0 == 0 goto $r1 = staticinvoke <com.google.rpc.Help$Link: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$r1 = staticinvoke <com.google.rpc.Help$Link: com.google.protobuf.Descriptors$Descriptor getDescriptor()>();	$i1 = virtualinvoke $r1.<java.lang.Object: int hashCode()>();	i11 = 779 + $i1;	$i2 = 37 * i11;	i12 = $i2 + 1;	$i4 = 53 * i12;	$r2 = virtualinvoke r0.<com.google.rpc.Help$Link: java.lang.String getDescription()>();	$i3 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	i13 = $i4 + $i3;	$i5 = 37 * i13;	i14 = $i5 + 2;	$i7 = 53 * i14;	$r3 = virtualinvoke r0.<com.google.rpc.Help$Link: java.lang.String getUrl()>();	$i6 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	i15 = $i7 + $i6;	$i9 = 29 * i15;	$r4 = virtualinvoke r0.<com.google.rpc.Help$Link: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$i8 = virtualinvoke $r4.<com.google.protobuf.UnknownFieldSet: int hashCode()>();	i16 = $i9 + $i8;	r0.<com.google.rpc.Help$Link: int memoizedHashCode> = i16;	return i16
;block_num 2