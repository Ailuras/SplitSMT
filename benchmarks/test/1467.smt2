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

(declare-sort var3673 0)
(declare-sort var277 0)
(declare-sort var3414 0)
(declare-sort var905 0)
(declare-sort var238 0)
(declare-sort var2907 0)
(declare-sort var1533 0)
(declare-sort var2764 0)
(declare-sort var2062 0)
(declare-sort var367 0)
(declare-sort var480 0)
(declare-sort var549 0)
(declare-sort var1639 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-2070795087 (var3673) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun beforeSize/-2070795087 (var3673) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun nodeOutputSize/-2070795087 (var3673) Int)
(declare-fun chainOutputSize/-2070795087 (var3673) Int)
(declare-fun routerMessage/-2070795087 (var3673) String)
(declare-fun nodeOutputInvokers/-2070795087 (var3673) var3414)
(declare-fun var905_isEmpty/73262611 (var238) Bool)
(declare-fun cast-from-var3414-to-var238 (var3414) var238)
(declare-fun var3414_size/-959786421 (var3414) Int)
(declare-fun var2907_min/-1112089438 (Int Int) Int)
(declare-fun var3414_subList/1175967931 (var3414 Int Int) var3414)
(declare-fun var238_stream/-1288525013 (var238) var1533)
(declare-fun var2062_bootstrap$/-617288192 () var2764)
(declare-fun var1533_map/130902797 (var1533 var2764) var1533)
(declare-fun var367_bootstrap$/-1893332706 () var2764)
(declare-fun var549_joining/-1302177485 (String) var480)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1533_collect/-2050842585 (var1533 var480) var1639)
(declare-fun cast-from-var1639-to-String (var1639) String)
(declare-fun nextNode/-2070795087 (var3673) var3414)
(declare-fun var3414_iterator/-912451715 (var3414) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3673 var3673)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const null-var3414 var3414)
(declare-const var724 var3673) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode 
(assert (not (= var724 null-var3673)))
(declare-const var447 Int) ; Statement: i3 := @parameter0: int 
(assert (not (= var447 null-Int)))
(define-const var2818 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2818)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2818!1 String)
(assert (= var2818!1 ""))
(assert true)
(define-const var1550 String (append/672562846 var2818!1 "[ ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ") 
(declare-const var2818!2 String)
(assert (= var2818!2 (str.++ var2818!1 "[ ")))
(define-const var911 String (name/-2070795087 var724)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name> 
(assert true)
(define-const var3052 String (append/672562846 var1550 var911)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1550!1 String)
(assert (= var1550!1 (str.++ var1550 var911)))
(assert true)
(define-const var849 String (append/-1166366385 var3052 32)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var3052!1 String)
(assert (str.prefixof var3052 var3052!1))
(assert true)
(define-const var1263 String (append/672562846 var849 "(Input: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ") 
(declare-const var849!1 String)
(assert (= var849!1 (str.++ var849 "(Input: ")))
(define-const var3087 Int (beforeSize/-2070795087 var724)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize> 
(assert true)
(define-const var1987 String (append/-1001720160 var1263 var3087)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1263!1 String)
(assert (str.prefixof var1263 var1263!1))
(assert true)
(define-const var471 String (append/672562846 var1987 ") ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var1987!1 String)
(assert (= var1987!1 (str.++ var1987 ") ")))
(assert true)
(define-const var2861 String (append/672562846 var471 "(Current Node Output: ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ") 
(declare-const var471!1 String)
(assert (= var471!1 (str.++ var471 "(Current Node Output: ")))
(define-const var3444 Int (nodeOutputSize/-2070795087 var724)) ; Statement: $i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize> 
(assert true)
(define-const var730 String (append/-1001720160 var2861 var3444)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var2861!1 String)
(assert (str.prefixof var2861 var2861!1))
(assert true)
(define-const var3705 String (append/672562846 var730 ") ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var730!1 String)
(assert (= var730!1 (str.++ var730 ") ")))
(assert true)
(define-const var1803 String (append/672562846 var3705 "(Chain Node Output: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ") 
(declare-const var3705!1 String)
(assert (= var3705!1 (str.++ var3705 "(Chain Node Output: ")))
(define-const var3100 Int (chainOutputSize/-2070795087 var724)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize> 
(assert true)
(define-const var3543 String (append/-1001720160 var1803 var3100)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var1803!1 String)
(assert (str.prefixof var1803 var1803!1))
(assert true)
(define-const var3260 String (append/-1166366385 var3543 41)) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var3543!1 String)
(assert (str.prefixof var3543 var3543!1))
(define-const var3894 String (routerMessage/-2070795087 var724)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r14 != null goto $r61 = " Router message: " 
(assert (not (= var3894 null-String))) ; Cond: $r14 != null 
(define-const var1138 String " Router message: ") ; Statement: $r61 = " Router message: " 
(assert true) ; Non Conditional
(assert true)
(define-const var234 String (append/672562846 var3260 var1138)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var3260!1 String)
(assert (= var3260!1 (str.++ var3260 var1138)))
(define-const var2972 String (routerMessage/-2070795087 var724)) ; Statement: $r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert (not (= var2972 null-String))) ; Cond: $r16 != null 
(define-const var3323 String (routerMessage/-2070795087 var724)) ; Statement: $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert true) ; Non Conditional
(assert true)
(define-const var335 String (append/672562846 var234 var3323)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var234!1 String)
(assert (= var234!1 (str.++ var234 var3323)))
(assert true)
;(assert (append/672562846 var335 " ] ")) ; Statement: virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ") 
(declare-const var335!1 String)
(assert (= var335!1 (str.++ var335 " ] ")))
 ; Statement: if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(assert (not (= var447 1))) ; Cond: i3 != 1 
(assert true)
(define-const var1631 String (append/672562846 var2818!2 "Current Node Output: ")) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(declare-const var2818!3 String)
(assert (= var2818!3 (str.++ var2818!2 "Current Node Output: ")))
(define-const var1201 var3414 (nodeOutputInvokers/-2070795087 var724)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var3151 Bool (var905_isEmpty/73262611 (cast-from-var3414-to-var238 var1201))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(assert (= (ite var3151 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1487 var3414 (nodeOutputInvokers/-2070795087 var724)) ; Statement: $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var2434 var3414 (nodeOutputInvokers/-2070795087 var724)) ; Statement: $r20 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var3012 Int (var3414_size/-959786421 var2434)) ; Statement: $i4 = interfaceinvoke $r20.<java.util.List: int size()>() 
(define-const var2784 Int (var2907_min/-1112089438 5 var3012)) ; Statement: $i5 = staticinvoke <java.lang.Math: int min(int,int)>(5, $i4) 
(define-const var1759 var3414 (var3414_subList/1175967931 var1487 0 var2784)) ; Statement: $r22 = interfaceinvoke $r21.<java.util.List: java.util.List subList(int,int)>(0, $i5) 
(define-const var548 var1533 (var238_stream/-1288525013 (cast-from-var3414-to-var238 var1759))) ; Statement: $r24 = interfaceinvoke $r22.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var3165 var2764 var2062_bootstrap$/-617288192) ; Statement: $r23 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65: java.util.function.Function bootstrap$()>() 
(define-const var2628 var1533 (var1533_map/130902797 var548 var3165)) ; Statement: $r26 = interfaceinvoke $r24.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r23) 
(define-const var2655 var2764 var367_bootstrap$/-1893332706) ; Statement: $r25 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73: java.util.function.Function bootstrap$()>() 
(define-const var3668 var1533 (var1533_map/130902797 var2628 var2655)) ; Statement: $r28 = interfaceinvoke $r26.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r25) 
(define-const var86 var480 (var549_joining/-1302177485 (cast-from-String-to-String ","))) ; Statement: $r27 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(",") 
(define-const var1432 var1639 (var1533_collect/-2050842585 var3668 var86)) ; Statement: $r29 = interfaceinvoke $r28.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r27) 
(define-const var2055 String (cast-from-var1639-to-String var1432)) ; Statement: $r65 = (java.lang.String) $r29 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var1631 var2055)) ; Statement: virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var1631!1 String)
(assert (= var1631!1 (str.++ var1631 var2055)))
(assert true) ; Non Conditional
(define-const var2584 var3414 (nodeOutputInvokers/-2070795087 var724)) ; Statement: $r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
 ; Statement: if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(assert (= var2584 null-var3414)) ; Cond: $r66 == null 
(define-const var3780 var3414 (nextNode/-2070795087 var724)) ; Statement: $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(define-const var2237 Iterator (var3414_iterator/-912451715 var3780)) ; Statement: $r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var263 Bool (Iterator_hasNext/-1669924200 var2237)) ; Statement: $z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var263 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var2747 String (toString/-2075883882 var2818!3)) ; Statement: $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), beforeSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), nodeOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), chainOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), routerMessage/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), nodeOutputInvokers/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var905_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var3414-to-var238=([java.util.List], java.util.Collection), var3414_size/-959786421=([java.util.List], int), var2907_min/-1112089438=([int, int], int), var3414_subList/1175967931=([java.util.List, int, int], java.util.List), var238_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), var2062_bootstrap$/-617288192=([], java.util.function.Function), var1533_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var367_bootstrap$/-1893332706=([], java.util.function.Function), var549_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1533_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1639-to-String=([java.lang.Object], java.lang.String), nextNode/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var3414_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3673=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode, var724=r1, var447=i3, var2818=$r0, var1550=$r3, var911=$r2, var3052=$r4, var849=$r5, var1263=$r6, var3087=$i0, var1987=$r7, var471=$r8, var2861=$r9, var3444=$i1, var730=$r10, var3705=$r11, var1803=$r12, var3100=$i2, var3543=$r13, var3260=$r15, var3894=$r14, var277=null_type, var1138=$r61, var234=$r17, var2972=$r16, var3323=$r62, var335=$r18, var1631=$r30, var3414=java.util.List, var1201=$r19, var905=org.apache.dubbo.common.utils.CollectionUtils, var238=java.util.Collection, var3151=$z0, var1487=$r21, var2434=$r20, var3012=$i4, var2907=java.lang.Math, var2784=$i5, var1759=$r22, var1533=java.util.stream.Stream, var548=$r24, var2764=java.util.function.Function, var2062=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65, var3165=$r23, var2628=$r26, var367=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73, var2655=$r25, var3668=$r28, var480=java.util.stream.Collector, var549=java.util.stream.Collectors, var86=$r27, var1639=java.lang.Object, var1432=$r29, var2055=$r65, var2584=$r66, var3780=$r67, var2237=$r68, var263=$z3, var2747=$r31}
; {org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode=var3673, r1=var724, i3=var447, $r0=var2818, $r3=var1550, $r2=var911, $r4=var3052, $r5=var849, $r6=var1263, $i0=var3087, $r7=var1987, $r8=var471, $r9=var2861, $i1=var3444, $r10=var730, $r11=var3705, $r12=var1803, $i2=var3100, $r13=var3543, $r15=var3260, $r14=var3894, null_type=var277, $r61=var1138, $r17=var234, $r16=var2972, $r62=var3323, $r18=var335, $r30=var1631, java.util.List=var3414, $r19=var1201, org.apache.dubbo.common.utils.CollectionUtils=var905, java.util.Collection=var238, $z0=var3151, $r21=var1487, $r20=var2434, $i4=var3012, java.lang.Math=var2907, $i5=var2784, $r22=var1759, java.util.stream.Stream=var1533, $r24=var548, java.util.function.Function=var2764, org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65=var2062, $r23=var3165, $r26=var2628, org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73=var367, $r25=var2655, $r28=var3668, java.util.stream.Collector=var480, java.util.stream.Collectors=var549, $r27=var86, java.lang.Object=var1639, $r29=var1432, $r65=var2055, $r66=var2584, $r67=var3780, $r68=var2237, $z3=var263, $r31=var2747}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode;	i3 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ");	$i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ");	$i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r14 != null goto $r61 = " Router message: ";	$r61 = " Router message: ";	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ");	if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r20 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$i4 = interfaceinvoke $r20.<java.util.List: int size()>();	$i5 = staticinvoke <java.lang.Math: int min(int,int)>(5, $i4);	$r22 = interfaceinvoke $r21.<java.util.List: java.util.List subList(int,int)>(0, $i5);	$r24 = interfaceinvoke $r22.<java.util.List: java.util.stream.Stream stream()>();	$r23 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65: java.util.function.Function bootstrap$()>();	$r26 = interfaceinvoke $r24.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r23);	$r25 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73: java.util.function.Function bootstrap$()>();	$r28 = interfaceinvoke $r26.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r25);	$r27 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(",");	$r29 = interfaceinvoke $r28.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r27);	$r65 = (java.lang.String) $r29;	virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r31
;block_num 12