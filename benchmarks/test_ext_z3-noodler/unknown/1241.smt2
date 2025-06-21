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

(declare-sort var2398 0)
(declare-sort var3382 0)
(declare-sort var560 0)
(declare-sort var2693 0)
(declare-sort var3899 0)
(declare-sort var549 0)
(declare-sort var1112 0)
(declare-sort var3888 0)
(declare-sort var1151 0)
(declare-sort var483 0)
(declare-sort var572 0)
(declare-sort var992 0)
(declare-sort var2400 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-2070795087 (var2398) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun beforeSize/-2070795087 (var2398) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun nodeOutputSize/-2070795087 (var2398) Int)
(declare-fun chainOutputSize/-2070795087 (var2398) Int)
(declare-fun routerMessage/-2070795087 (var2398) String)
(declare-fun nodeOutputInvokers/-2070795087 (var2398) var560)
(declare-fun var2693_isEmpty/73262611 (var3899) Bool)
(declare-fun cast-from-var560-to-var3899 (var560) var3899)
(declare-fun var560_size/-959786421 (var560) Int)
(declare-fun var549_min/-1112089438 (Int Int) Int)
(declare-fun var560_subList/1175967931 (var560 Int Int) var560)
(declare-fun var3899_stream/-1288525013 (var3899) var1112)
(declare-fun var1151_bootstrap$/-617288192 () var3888)
(declare-fun var1112_map/130902797 (var1112 var3888) var1112)
(declare-fun var483_bootstrap$/-1893332706 () var3888)
(declare-fun var992_joining/-1302177485 (String) var572)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1112_collect/-2050842585 (var1112 var572) var2400)
(declare-fun cast-from-var2400-to-String (var2400) String)
(declare-fun nextNode/-2070795087 (var2398) var560)
(declare-fun var560_iterator/-912451715 (var560) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2398 var2398)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const null-var560 var560)
(declare-const var2930 var2398) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode 
(assert (not (= var2930 null-var2398)))
(declare-const var3973 Int) ; Statement: i3 := @parameter0: int 
(assert (not (= var3973 null-Int)))
(define-const var1093 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1093)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1093!1 String)
(assert (= var1093!1 ""))
(assert true)
(define-const var3947 String (append/672562846 var1093!1 "[ ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ") 
(declare-const var1093!2 String)
(assert (= var1093!2 (str.++ var1093!1 "[ ")))
(define-const var1166 String (name/-2070795087 var2930)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name> 
(assert true)
(define-const var907 String (append/672562846 var3947 var1166)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3947!1 String)
(assert (= var3947!1 (str.++ var3947 var1166)))
(assert true)
(define-const var1286 String (append/-1166366385 var907 32)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var907!1 String)
(assert (str.prefixof var907 var907!1))
(assert true)
(define-const var3953 String (append/672562846 var1286 "(Input: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ") 
(declare-const var1286!1 String)
(assert (= var1286!1 (str.++ var1286 "(Input: ")))
(define-const var3726 Int (beforeSize/-2070795087 var2930)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize> 
(assert true)
(define-const var3773 String (append/-1001720160 var3953 var3726)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3953!1 String)
(assert (str.prefixof var3953 var3953!1))
(assert true)
(define-const var3975 String (append/672562846 var3773 ") ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var3773!1 String)
(assert (= var3773!1 (str.++ var3773 ") ")))
(assert true)
(define-const var3348 String (append/672562846 var3975 "(Current Node Output: ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ") 
(declare-const var3975!1 String)
(assert (= var3975!1 (str.++ var3975 "(Current Node Output: ")))
(define-const var3478 Int (nodeOutputSize/-2070795087 var2930)) ; Statement: $i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize> 
(assert true)
(define-const var345 String (append/-1001720160 var3348 var3478)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var3348!1 String)
(assert (str.prefixof var3348 var3348!1))
(assert true)
(define-const var3439 String (append/672562846 var345 ") ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var345!1 String)
(assert (= var345!1 (str.++ var345 ") ")))
(assert true)
(define-const var2025 String (append/672562846 var3439 "(Chain Node Output: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ") 
(declare-const var3439!1 String)
(assert (= var3439!1 (str.++ var3439 "(Chain Node Output: ")))
(define-const var3101 Int (chainOutputSize/-2070795087 var2930)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize> 
(assert true)
(define-const var2622 String (append/-1001720160 var2025 var3101)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var2025!1 String)
(assert (str.prefixof var2025 var2025!1))
(assert true)
(define-const var199 String (append/-1166366385 var2622 41)) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var2622!1 String)
(assert (str.prefixof var2622 var2622!1))
(define-const var2662 String (routerMessage/-2070795087 var2930)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r14 != null goto $r61 = " Router message: " 
(assert (not (not (= var2662 null-String)))) ; Negate: Cond: $r14 != null  
(define-const var185 String "") ; Statement: $r61 = "" 
 ; Statement: goto [?= $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2054 String (append/672562846 var199 var185)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var199!1 String)
(assert (= var199!1 (str.++ var199 var185)))
(define-const var949 String (routerMessage/-2070795087 var2930)) ; Statement: $r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert (not (not (= var949 null-String)))) ; Negate: Cond: $r16 != null  
(define-const var558 String "") ; Statement: $r62 = "" 
 ; Statement: goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62)] 
(assert true) ; Non Conditional
(assert true)
(define-const var3931 String (append/672562846 var2054 var558)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var2054!1 String)
(assert (= var2054!1 (str.++ var2054 var558)))
(assert true)
;(assert (append/672562846 var3931 " ] ")) ; Statement: virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ") 
(declare-const var3931!1 String)
(assert (= var3931!1 (str.++ var3931 " ] ")))
 ; Statement: if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(assert (not (= var3973 1))) ; Cond: i3 != 1 
(assert true)
(define-const var1187 String (append/672562846 var1093!2 "Current Node Output: ")) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(declare-const var1093!3 String)
(assert (= var1093!3 (str.++ var1093!2 "Current Node Output: ")))
(define-const var1529 var560 (nodeOutputInvokers/-2070795087 var2930)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var3284 Bool (var2693_isEmpty/73262611 (cast-from-var560-to-var3899 var1529))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(assert (= (ite var3284 1 0) 0)) ; Cond: $z0 == 0 
(define-const var11 var560 (nodeOutputInvokers/-2070795087 var2930)) ; Statement: $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var1391 var560 (nodeOutputInvokers/-2070795087 var2930)) ; Statement: $r20 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var1064 Int (var560_size/-959786421 var1391)) ; Statement: $i4 = interfaceinvoke $r20.<java.util.List: int size()>() 
(define-const var3230 Int (var549_min/-1112089438 5 var1064)) ; Statement: $i5 = staticinvoke <java.lang.Math: int min(int,int)>(5, $i4) 
(define-const var3290 var560 (var560_subList/1175967931 var11 0 var3230)) ; Statement: $r22 = interfaceinvoke $r21.<java.util.List: java.util.List subList(int,int)>(0, $i5) 
(define-const var966 var1112 (var3899_stream/-1288525013 (cast-from-var560-to-var3899 var3290))) ; Statement: $r24 = interfaceinvoke $r22.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var3474 var3888 var1151_bootstrap$/-617288192) ; Statement: $r23 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65: java.util.function.Function bootstrap$()>() 
(define-const var3294 var1112 (var1112_map/130902797 var966 var3474)) ; Statement: $r26 = interfaceinvoke $r24.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r23) 
(define-const var795 var3888 var483_bootstrap$/-1893332706) ; Statement: $r25 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73: java.util.function.Function bootstrap$()>() 
(define-const var989 var1112 (var1112_map/130902797 var3294 var795)) ; Statement: $r28 = interfaceinvoke $r26.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r25) 
(define-const var3327 var572 (var992_joining/-1302177485 (cast-from-String-to-String ","))) ; Statement: $r27 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(",") 
(define-const var1300 var2400 (var1112_collect/-2050842585 var989 var3327)) ; Statement: $r29 = interfaceinvoke $r28.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r27) 
(define-const var757 String (cast-from-var2400-to-String var1300)) ; Statement: $r65 = (java.lang.String) $r29 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var1187 var757)) ; Statement: virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var1187!1 String)
(assert (= var1187!1 (str.++ var1187 var757)))
(assert true) ; Non Conditional
(define-const var302 var560 (nodeOutputInvokers/-2070795087 var2930)) ; Statement: $r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
 ; Statement: if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(assert (= var302 null-var560)) ; Cond: $r66 == null 
(define-const var2176 var560 (nextNode/-2070795087 var2930)) ; Statement: $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(define-const var3621 Iterator (var560_iterator/-912451715 var2176)) ; Statement: $r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2175 Bool (Iterator_hasNext/-1669924200 var3621)) ; Statement: $z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2175 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var1523 String (toString/-2075883882 var1093!3)) ; Statement: $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), beforeSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), nodeOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), chainOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), routerMessage/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), nodeOutputInvokers/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var2693_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var560-to-var3899=([java.util.List], java.util.Collection), var560_size/-959786421=([java.util.List], int), var549_min/-1112089438=([int, int], int), var560_subList/1175967931=([java.util.List, int, int], java.util.List), var3899_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), var1151_bootstrap$/-617288192=([], java.util.function.Function), var1112_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var483_bootstrap$/-1893332706=([], java.util.function.Function), var992_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1112_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var2400-to-String=([java.lang.Object], java.lang.String), nextNode/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var560_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2398=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode, var2930=r1, var3973=i3, var1093=$r0, var3947=$r3, var1166=$r2, var907=$r4, var1286=$r5, var3953=$r6, var3726=$i0, var3773=$r7, var3975=$r8, var3348=$r9, var3478=$i1, var345=$r10, var3439=$r11, var2025=$r12, var3101=$i2, var2622=$r13, var199=$r15, var2662=$r14, var3382=null_type, var185=$r61, var2054=$r17, var949=$r16, var558=$r62, var3931=$r18, var1187=$r30, var560=java.util.List, var1529=$r19, var2693=org.apache.dubbo.common.utils.CollectionUtils, var3899=java.util.Collection, var3284=$z0, var11=$r21, var1391=$r20, var1064=$i4, var549=java.lang.Math, var3230=$i5, var3290=$r22, var1112=java.util.stream.Stream, var966=$r24, var3888=java.util.function.Function, var1151=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65, var3474=$r23, var3294=$r26, var483=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73, var795=$r25, var989=$r28, var572=java.util.stream.Collector, var992=java.util.stream.Collectors, var3327=$r27, var2400=java.lang.Object, var1300=$r29, var757=$r65, var302=$r66, var2176=$r67, var3621=$r68, var2175=$z3, var1523=$r31}
; {org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode=var2398, r1=var2930, i3=var3973, $r0=var1093, $r3=var3947, $r2=var1166, $r4=var907, $r5=var1286, $r6=var3953, $i0=var3726, $r7=var3773, $r8=var3975, $r9=var3348, $i1=var3478, $r10=var345, $r11=var3439, $r12=var2025, $i2=var3101, $r13=var2622, $r15=var199, $r14=var2662, null_type=var3382, $r61=var185, $r17=var2054, $r16=var949, $r62=var558, $r18=var3931, $r30=var1187, java.util.List=var560, $r19=var1529, org.apache.dubbo.common.utils.CollectionUtils=var2693, java.util.Collection=var3899, $z0=var3284, $r21=var11, $r20=var1391, $i4=var1064, java.lang.Math=var549, $i5=var3230, $r22=var3290, java.util.stream.Stream=var1112, $r24=var966, java.util.function.Function=var3888, org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65=var1151, $r23=var3474, $r26=var3294, org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73=var483, $r25=var795, $r28=var989, java.util.stream.Collector=var572, java.util.stream.Collectors=var992, $r27=var3327, java.lang.Object=var2400, $r29=var1300, $r65=var757, $r66=var302, $r67=var2176, $r68=var3621, $z3=var2175, $r31=var1523}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode;	i3 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ");	$i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ");	$i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r14 != null goto $r61 = " Router message: ";	$r61 = "";	goto [?= $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)];	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r62 = "";	goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62)];	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ");	if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r20 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$i4 = interfaceinvoke $r20.<java.util.List: int size()>();	$i5 = staticinvoke <java.lang.Math: int min(int,int)>(5, $i4);	$r22 = interfaceinvoke $r21.<java.util.List: java.util.List subList(int,int)>(0, $i5);	$r24 = interfaceinvoke $r22.<java.util.List: java.util.stream.Stream stream()>();	$r23 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65: java.util.function.Function bootstrap$()>();	$r26 = interfaceinvoke $r24.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r23);	$r25 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73: java.util.function.Function bootstrap$()>();	$r28 = interfaceinvoke $r26.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r25);	$r27 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(",");	$r29 = interfaceinvoke $r28.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r27);	$r65 = (java.lang.String) $r29;	virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r31
;block_num 12