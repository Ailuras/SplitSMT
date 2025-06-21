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

(declare-sort var1660 0)
(declare-sort var225 0)
(declare-sort var738 0)
(declare-sort var1448 0)
(declare-sort var552 0)
(declare-sort var2902 0)
(declare-sort var2396 0)
(declare-sort var1918 0)
(declare-sort var798 0)
(declare-sort var2205 0)
(declare-sort var1570 0)
(declare-sort var607 0)
(declare-sort var2987 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-2070795087 (var1660) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun beforeSize/-2070795087 (var1660) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun nodeOutputSize/-2070795087 (var1660) Int)
(declare-fun chainOutputSize/-2070795087 (var1660) Int)
(declare-fun routerMessage/-2070795087 (var1660) String)
(declare-fun nodeOutputInvokers/-2070795087 (var1660) var738)
(declare-fun var1448_isEmpty/73262611 (var552) Bool)
(declare-fun cast-from-var738-to-var552 (var738) var552)
(declare-fun var738_size/-959786421 (var738) Int)
(declare-fun var2902_min/-1112089438 (Int Int) Int)
(declare-fun var738_subList/1175967931 (var738 Int Int) var738)
(declare-fun var552_stream/-1288525013 (var552) var2396)
(declare-fun var798_bootstrap$/-617288192 () var1918)
(declare-fun var2396_map/130902797 (var2396 var1918) var2396)
(declare-fun var2205_bootstrap$/-1893332706 () var1918)
(declare-fun var607_joining/-1302177485 (String) var1570)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2396_collect/-2050842585 (var2396 var1570) var2987)
(declare-fun cast-from-var2987-to-String (var2987) String)
(declare-fun nextNode/-2070795087 (var1660) var738)
(declare-fun var738_iterator/-912451715 (var738) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1660 var1660)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const null-var738 var738)
(declare-const var2436 var1660) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode 
(assert (not (= var2436 null-var1660)))
(declare-const var2221 Int) ; Statement: i3 := @parameter0: int 
(assert (not (= var2221 null-Int)))
(define-const var1595 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1595)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1595!1 String)
(assert (= var1595!1 ""))
(assert true)
(define-const var1997 String (append/672562846 var1595!1 "[ ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ") 
(declare-const var1595!2 String)
(assert (= var1595!2 (str.++ var1595!1 "[ ")))
(define-const var259 String (name/-2070795087 var2436)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name> 
(assert true)
(define-const var890 String (append/672562846 var1997 var259)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1997!1 String)
(assert (= var1997!1 (str.++ var1997 var259)))
(assert true)
(define-const var104 String (append/-1166366385 var890 32)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var890!1 String)
(assert (str.prefixof var890 var890!1))
(assert true)
(define-const var1372 String (append/672562846 var104 "(Input: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ") 
(declare-const var104!1 String)
(assert (= var104!1 (str.++ var104 "(Input: ")))
(define-const var2222 Int (beforeSize/-2070795087 var2436)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize> 
(assert true)
(define-const var549 String (append/-1001720160 var1372 var2222)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1372!1 String)
(assert (str.prefixof var1372 var1372!1))
(assert true)
(define-const var2725 String (append/672562846 var549 ") ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var549!1 String)
(assert (= var549!1 (str.++ var549 ") ")))
(assert true)
(define-const var3185 String (append/672562846 var2725 "(Current Node Output: ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ") 
(declare-const var2725!1 String)
(assert (= var2725!1 (str.++ var2725 "(Current Node Output: ")))
(define-const var1093 Int (nodeOutputSize/-2070795087 var2436)) ; Statement: $i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize> 
(assert true)
(define-const var1197 String (append/-1001720160 var3185 var1093)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var3185!1 String)
(assert (str.prefixof var3185 var3185!1))
(assert true)
(define-const var947 String (append/672562846 var1197 ") ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var1197!1 String)
(assert (= var1197!1 (str.++ var1197 ") ")))
(assert true)
(define-const var1802 String (append/672562846 var947 "(Chain Node Output: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ") 
(declare-const var947!1 String)
(assert (= var947!1 (str.++ var947 "(Chain Node Output: ")))
(define-const var1461 Int (chainOutputSize/-2070795087 var2436)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize> 
(assert true)
(define-const var1678 String (append/-1001720160 var1802 var1461)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var1802!1 String)
(assert (str.prefixof var1802 var1802!1))
(assert true)
(define-const var652 String (append/-1166366385 var1678 41)) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var1678!1 String)
(assert (str.prefixof var1678 var1678!1))
(define-const var1466 String (routerMessage/-2070795087 var2436)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r14 != null goto $r61 = " Router message: " 
(assert (not (= var1466 null-String))) ; Cond: $r14 != null 
(define-const var1155 String " Router message: ") ; Statement: $r61 = " Router message: " 
(assert true) ; Non Conditional
(assert true)
(define-const var3479 String (append/672562846 var652 var1155)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var652!1 String)
(assert (= var652!1 (str.++ var652 var1155)))
(define-const var2276 String (routerMessage/-2070795087 var2436)) ; Statement: $r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert (not (not (= var2276 null-String)))) ; Negate: Cond: $r16 != null  
(define-const var1917 String "") ; Statement: $r62 = "" 
 ; Statement: goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1809 String (append/672562846 var3479 var1917)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var3479!1 String)
(assert (= var3479!1 (str.++ var3479 var1917)))
(assert true)
;(assert (append/672562846 var1809 " ] ")) ; Statement: virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ") 
(declare-const var1809!1 String)
(assert (= var1809!1 (str.++ var1809 " ] ")))
 ; Statement: if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(assert (not (= var2221 1))) ; Cond: i3 != 1 
(assert true)
(define-const var2591 String (append/672562846 var1595!2 "Current Node Output: ")) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(declare-const var1595!3 String)
(assert (= var1595!3 (str.++ var1595!2 "Current Node Output: ")))
(define-const var2487 var738 (nodeOutputInvokers/-2070795087 var2436)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var2572 Bool (var1448_isEmpty/73262611 (cast-from-var738-to-var552 var2487))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(assert (= (ite var2572 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2560 var738 (nodeOutputInvokers/-2070795087 var2436)) ; Statement: $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var2275 var738 (nodeOutputInvokers/-2070795087 var2436)) ; Statement: $r20 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var3673 Int (var738_size/-959786421 var2275)) ; Statement: $i4 = interfaceinvoke $r20.<java.util.List: int size()>() 
(define-const var1163 Int (var2902_min/-1112089438 5 var3673)) ; Statement: $i5 = staticinvoke <java.lang.Math: int min(int,int)>(5, $i4) 
(define-const var3629 var738 (var738_subList/1175967931 var2560 0 var1163)) ; Statement: $r22 = interfaceinvoke $r21.<java.util.List: java.util.List subList(int,int)>(0, $i5) 
(define-const var634 var2396 (var552_stream/-1288525013 (cast-from-var738-to-var552 var3629))) ; Statement: $r24 = interfaceinvoke $r22.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var2279 var1918 var798_bootstrap$/-617288192) ; Statement: $r23 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65: java.util.function.Function bootstrap$()>() 
(define-const var3060 var2396 (var2396_map/130902797 var634 var2279)) ; Statement: $r26 = interfaceinvoke $r24.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r23) 
(define-const var3716 var1918 var2205_bootstrap$/-1893332706) ; Statement: $r25 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73: java.util.function.Function bootstrap$()>() 
(define-const var285 var2396 (var2396_map/130902797 var3060 var3716)) ; Statement: $r28 = interfaceinvoke $r26.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r25) 
(define-const var142 var1570 (var607_joining/-1302177485 (cast-from-String-to-String ","))) ; Statement: $r27 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(",") 
(define-const var3289 var2987 (var2396_collect/-2050842585 var285 var142)) ; Statement: $r29 = interfaceinvoke $r28.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r27) 
(define-const var2415 String (cast-from-var2987-to-String var3289)) ; Statement: $r65 = (java.lang.String) $r29 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var2591 var2415)) ; Statement: virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var2591!1 String)
(assert (= var2591!1 (str.++ var2591 var2415)))
(assert true) ; Non Conditional
(define-const var3691 var738 (nodeOutputInvokers/-2070795087 var2436)) ; Statement: $r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
 ; Statement: if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(assert (= var3691 null-var738)) ; Cond: $r66 == null 
(define-const var2214 var738 (nextNode/-2070795087 var2436)) ; Statement: $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(define-const var3748 Iterator (var738_iterator/-912451715 var2214)) ; Statement: $r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3471 Bool (Iterator_hasNext/-1669924200 var3748)) ; Statement: $z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3471 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var870 String (toString/-2075883882 var1595!3)) ; Statement: $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), beforeSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), nodeOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), chainOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), routerMessage/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), nodeOutputInvokers/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var1448_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var738-to-var552=([java.util.List], java.util.Collection), var738_size/-959786421=([java.util.List], int), var2902_min/-1112089438=([int, int], int), var738_subList/1175967931=([java.util.List, int, int], java.util.List), var552_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), var798_bootstrap$/-617288192=([], java.util.function.Function), var2396_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var2205_bootstrap$/-1893332706=([], java.util.function.Function), var607_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2396_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var2987-to-String=([java.lang.Object], java.lang.String), nextNode/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var738_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1660=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode, var2436=r1, var2221=i3, var1595=$r0, var1997=$r3, var259=$r2, var890=$r4, var104=$r5, var1372=$r6, var2222=$i0, var549=$r7, var2725=$r8, var3185=$r9, var1093=$i1, var1197=$r10, var947=$r11, var1802=$r12, var1461=$i2, var1678=$r13, var652=$r15, var1466=$r14, var225=null_type, var1155=$r61, var3479=$r17, var2276=$r16, var1917=$r62, var1809=$r18, var2591=$r30, var738=java.util.List, var2487=$r19, var1448=org.apache.dubbo.common.utils.CollectionUtils, var552=java.util.Collection, var2572=$z0, var2560=$r21, var2275=$r20, var3673=$i4, var2902=java.lang.Math, var1163=$i5, var3629=$r22, var2396=java.util.stream.Stream, var634=$r24, var1918=java.util.function.Function, var798=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65, var2279=$r23, var3060=$r26, var2205=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73, var3716=$r25, var285=$r28, var1570=java.util.stream.Collector, var607=java.util.stream.Collectors, var142=$r27, var2987=java.lang.Object, var3289=$r29, var2415=$r65, var3691=$r66, var2214=$r67, var3748=$r68, var3471=$z3, var870=$r31}
; {org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode=var1660, r1=var2436, i3=var2221, $r0=var1595, $r3=var1997, $r2=var259, $r4=var890, $r5=var104, $r6=var1372, $i0=var2222, $r7=var549, $r8=var2725, $r9=var3185, $i1=var1093, $r10=var1197, $r11=var947, $r12=var1802, $i2=var1461, $r13=var1678, $r15=var652, $r14=var1466, null_type=var225, $r61=var1155, $r17=var3479, $r16=var2276, $r62=var1917, $r18=var1809, $r30=var2591, java.util.List=var738, $r19=var2487, org.apache.dubbo.common.utils.CollectionUtils=var1448, java.util.Collection=var552, $z0=var2572, $r21=var2560, $r20=var2275, $i4=var3673, java.lang.Math=var2902, $i5=var1163, $r22=var3629, java.util.stream.Stream=var2396, $r24=var634, java.util.function.Function=var1918, org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65=var798, $r23=var2279, $r26=var3060, org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73=var2205, $r25=var3716, $r28=var285, java.util.stream.Collector=var1570, java.util.stream.Collectors=var607, $r27=var142, java.lang.Object=var2987, $r29=var3289, $r65=var2415, $r66=var3691, $r67=var2214, $r68=var3748, $z3=var3471, $r31=var870}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode;	i3 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ");	$i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ");	$i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r14 != null goto $r61 = " Router message: ";	$r61 = " Router message: ";	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r62 = "";	goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62)];	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ");	if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r20 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$i4 = interfaceinvoke $r20.<java.util.List: int size()>();	$i5 = staticinvoke <java.lang.Math: int min(int,int)>(5, $i4);	$r22 = interfaceinvoke $r21.<java.util.List: java.util.List subList(int,int)>(0, $i5);	$r24 = interfaceinvoke $r22.<java.util.List: java.util.stream.Stream stream()>();	$r23 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65: java.util.function.Function bootstrap$()>();	$r26 = interfaceinvoke $r24.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r23);	$r25 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73: java.util.function.Function bootstrap$()>();	$r28 = interfaceinvoke $r26.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r25);	$r27 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(",");	$r29 = interfaceinvoke $r28.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r27);	$r65 = (java.lang.String) $r29;	virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r31
;block_num 12