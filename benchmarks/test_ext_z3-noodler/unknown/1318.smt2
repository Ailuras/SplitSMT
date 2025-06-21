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

(declare-sort var287 0)
(declare-sort var2764 0)
(declare-sort var769 0)
(declare-sort var889 0)
(declare-sort var3075 0)
(declare-sort var435 0)
(declare-sort var856 0)
(declare-sort var1467 0)
(declare-sort var3443 0)
(declare-sort var664 0)
(declare-sort var1564 0)
(declare-sort var70 0)
(declare-sort var1152 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-2070795087 (var287) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun beforeSize/-2070795087 (var287) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun nodeOutputSize/-2070795087 (var287) Int)
(declare-fun chainOutputSize/-2070795087 (var287) Int)
(declare-fun routerMessage/-2070795087 (var287) String)
(declare-fun nodeOutputInvokers/-2070795087 (var287) var769)
(declare-fun var889_isEmpty/73262611 (var3075) Bool)
(declare-fun cast-from-var769-to-var3075 (var769) var3075)
(declare-fun var769_size/-959786421 (var769) Int)
(declare-fun var435_min/-1112089438 (Int Int) Int)
(declare-fun var769_subList/1175967931 (var769 Int Int) var769)
(declare-fun var3075_stream/-1288525013 (var3075) var856)
(declare-fun var3443_bootstrap$/-617288192 () var1467)
(declare-fun var856_map/130902797 (var856 var1467) var856)
(declare-fun var664_bootstrap$/-1893332706 () var1467)
(declare-fun var70_joining/-1302177485 (String) var1564)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var856_collect/-2050842585 (var856 var1564) var1152)
(declare-fun cast-from-var1152-to-String (var1152) String)
(declare-fun nextNode/-2070795087 (var287) var769)
(declare-fun var769_iterator/-912451715 (var769) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var287 var287)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const null-var769 var769)
(declare-const var3166 var287) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode 
(assert (not (= var3166 null-var287)))
(declare-const var2715 Int) ; Statement: i3 := @parameter0: int 
(assert (not (= var2715 null-Int)))
(define-const var2759 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2759)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2759!1 String)
(assert (= var2759!1 ""))
(assert true)
(define-const var276 String (append/672562846 var2759!1 "[ ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ") 
(declare-const var2759!2 String)
(assert (= var2759!2 (str.++ var2759!1 "[ ")))
(define-const var604 String (name/-2070795087 var3166)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name> 
(assert true)
(define-const var806 String (append/672562846 var276 var604)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var276!1 String)
(assert (= var276!1 (str.++ var276 var604)))
(assert true)
(define-const var3077 String (append/-1166366385 var806 32)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var806!1 String)
(assert (str.prefixof var806 var806!1))
(assert true)
(define-const var2673 String (append/672562846 var3077 "(Input: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ") 
(declare-const var3077!1 String)
(assert (= var3077!1 (str.++ var3077 "(Input: ")))
(define-const var3273 Int (beforeSize/-2070795087 var3166)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize> 
(assert true)
(define-const var501 String (append/-1001720160 var2673 var3273)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var2673!1 String)
(assert (str.prefixof var2673 var2673!1))
(assert true)
(define-const var3579 String (append/672562846 var501 ") ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var501!1 String)
(assert (= var501!1 (str.++ var501 ") ")))
(assert true)
(define-const var2354 String (append/672562846 var3579 "(Current Node Output: ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ") 
(declare-const var3579!1 String)
(assert (= var3579!1 (str.++ var3579 "(Current Node Output: ")))
(define-const var2935 Int (nodeOutputSize/-2070795087 var3166)) ; Statement: $i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize> 
(assert true)
(define-const var587 String (append/-1001720160 var2354 var2935)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var2354!1 String)
(assert (str.prefixof var2354 var2354!1))
(assert true)
(define-const var2499 String (append/672562846 var587 ") ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var587!1 String)
(assert (= var587!1 (str.++ var587 ") ")))
(assert true)
(define-const var2434 String (append/672562846 var2499 "(Chain Node Output: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ") 
(declare-const var2499!1 String)
(assert (= var2499!1 (str.++ var2499 "(Chain Node Output: ")))
(define-const var1949 Int (chainOutputSize/-2070795087 var3166)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize> 
(assert true)
(define-const var1287 String (append/-1001720160 var2434 var1949)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var2434!1 String)
(assert (str.prefixof var2434 var2434!1))
(assert true)
(define-const var1305 String (append/-1166366385 var1287 41)) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var1287!1 String)
(assert (str.prefixof var1287 var1287!1))
(define-const var1756 String (routerMessage/-2070795087 var3166)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r14 != null goto $r61 = " Router message: " 
(assert (not (not (= var1756 null-String)))) ; Negate: Cond: $r14 != null  
(define-const var3993 String "") ; Statement: $r61 = "" 
 ; Statement: goto [?= $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1337 String (append/672562846 var1305 var3993)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var1305!1 String)
(assert (= var1305!1 (str.++ var1305 var3993)))
(define-const var1544 String (routerMessage/-2070795087 var3166)) ; Statement: $r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert (not (= var1544 null-String))) ; Cond: $r16 != null 
(define-const var2691 String (routerMessage/-2070795087 var3166)) ; Statement: $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert true) ; Non Conditional
(assert true)
(define-const var2015 String (append/672562846 var1337 var2691)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var1337!1 String)
(assert (= var1337!1 (str.++ var1337 var2691)))
(assert true)
;(assert (append/672562846 var2015 " ] ")) ; Statement: virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ") 
(declare-const var2015!1 String)
(assert (= var2015!1 (str.++ var2015 " ] ")))
 ; Statement: if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(assert (not (= var2715 1))) ; Cond: i3 != 1 
(assert true)
(define-const var3330 String (append/672562846 var2759!2 "Current Node Output: ")) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(declare-const var2759!3 String)
(assert (= var2759!3 (str.++ var2759!2 "Current Node Output: ")))
(define-const var1360 var769 (nodeOutputInvokers/-2070795087 var3166)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var3512 Bool (var889_isEmpty/73262611 (cast-from-var769-to-var3075 var1360))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(assert (= (ite var3512 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2196 var769 (nodeOutputInvokers/-2070795087 var3166)) ; Statement: $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var1957 var769 (nodeOutputInvokers/-2070795087 var3166)) ; Statement: $r20 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var3961 Int (var769_size/-959786421 var1957)) ; Statement: $i4 = interfaceinvoke $r20.<java.util.List: int size()>() 
(define-const var796 Int (var435_min/-1112089438 5 var3961)) ; Statement: $i5 = staticinvoke <java.lang.Math: int min(int,int)>(5, $i4) 
(define-const var37 var769 (var769_subList/1175967931 var2196 0 var796)) ; Statement: $r22 = interfaceinvoke $r21.<java.util.List: java.util.List subList(int,int)>(0, $i5) 
(define-const var3218 var856 (var3075_stream/-1288525013 (cast-from-var769-to-var3075 var37))) ; Statement: $r24 = interfaceinvoke $r22.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var36 var1467 var3443_bootstrap$/-617288192) ; Statement: $r23 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65: java.util.function.Function bootstrap$()>() 
(define-const var1032 var856 (var856_map/130902797 var3218 var36)) ; Statement: $r26 = interfaceinvoke $r24.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r23) 
(define-const var2378 var1467 var664_bootstrap$/-1893332706) ; Statement: $r25 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73: java.util.function.Function bootstrap$()>() 
(define-const var2409 var856 (var856_map/130902797 var1032 var2378)) ; Statement: $r28 = interfaceinvoke $r26.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r25) 
(define-const var3228 var1564 (var70_joining/-1302177485 (cast-from-String-to-String ","))) ; Statement: $r27 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(",") 
(define-const var2475 var1152 (var856_collect/-2050842585 var2409 var3228)) ; Statement: $r29 = interfaceinvoke $r28.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r27) 
(define-const var1323 String (cast-from-var1152-to-String var2475)) ; Statement: $r65 = (java.lang.String) $r29 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var3330 var1323)) ; Statement: virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var3330!1 String)
(assert (= var3330!1 (str.++ var3330 var1323)))
(assert true) ; Non Conditional
(define-const var2304 var769 (nodeOutputInvokers/-2070795087 var3166)) ; Statement: $r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
 ; Statement: if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(assert (= var2304 null-var769)) ; Cond: $r66 == null 
(define-const var1665 var769 (nextNode/-2070795087 var3166)) ; Statement: $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(define-const var851 Iterator (var769_iterator/-912451715 var1665)) ; Statement: $r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var971 Bool (Iterator_hasNext/-1669924200 var851)) ; Statement: $z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var971 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var1547 String (toString/-2075883882 var2759!3)) ; Statement: $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), beforeSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), nodeOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), chainOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), routerMessage/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), nodeOutputInvokers/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var889_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var769-to-var3075=([java.util.List], java.util.Collection), var769_size/-959786421=([java.util.List], int), var435_min/-1112089438=([int, int], int), var769_subList/1175967931=([java.util.List, int, int], java.util.List), var3075_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), var3443_bootstrap$/-617288192=([], java.util.function.Function), var856_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var664_bootstrap$/-1893332706=([], java.util.function.Function), var70_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var856_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var1152-to-String=([java.lang.Object], java.lang.String), nextNode/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var769_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var287=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode, var3166=r1, var2715=i3, var2759=$r0, var276=$r3, var604=$r2, var806=$r4, var3077=$r5, var2673=$r6, var3273=$i0, var501=$r7, var3579=$r8, var2354=$r9, var2935=$i1, var587=$r10, var2499=$r11, var2434=$r12, var1949=$i2, var1287=$r13, var1305=$r15, var1756=$r14, var2764=null_type, var3993=$r61, var1337=$r17, var1544=$r16, var2691=$r62, var2015=$r18, var3330=$r30, var769=java.util.List, var1360=$r19, var889=org.apache.dubbo.common.utils.CollectionUtils, var3075=java.util.Collection, var3512=$z0, var2196=$r21, var1957=$r20, var3961=$i4, var435=java.lang.Math, var796=$i5, var37=$r22, var856=java.util.stream.Stream, var3218=$r24, var1467=java.util.function.Function, var3443=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65, var36=$r23, var1032=$r26, var664=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73, var2378=$r25, var2409=$r28, var1564=java.util.stream.Collector, var70=java.util.stream.Collectors, var3228=$r27, var1152=java.lang.Object, var2475=$r29, var1323=$r65, var2304=$r66, var1665=$r67, var851=$r68, var971=$z3, var1547=$r31}
; {org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode=var287, r1=var3166, i3=var2715, $r0=var2759, $r3=var276, $r2=var604, $r4=var806, $r5=var3077, $r6=var2673, $i0=var3273, $r7=var501, $r8=var3579, $r9=var2354, $i1=var2935, $r10=var587, $r11=var2499, $r12=var2434, $i2=var1949, $r13=var1287, $r15=var1305, $r14=var1756, null_type=var2764, $r61=var3993, $r17=var1337, $r16=var1544, $r62=var2691, $r18=var2015, $r30=var3330, java.util.List=var769, $r19=var1360, org.apache.dubbo.common.utils.CollectionUtils=var889, java.util.Collection=var3075, $z0=var3512, $r21=var2196, $r20=var1957, $i4=var3961, java.lang.Math=var435, $i5=var796, $r22=var37, java.util.stream.Stream=var856, $r24=var3218, java.util.function.Function=var1467, org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65=var3443, $r23=var36, $r26=var1032, org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73=var664, $r25=var2378, $r28=var2409, java.util.stream.Collector=var1564, java.util.stream.Collectors=var70, $r27=var3228, java.lang.Object=var1152, $r29=var2475, $r65=var1323, $r66=var2304, $r67=var1665, $r68=var851, $z3=var971, $r31=var1547}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode;	i3 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ");	$i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ");	$i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r14 != null goto $r61 = " Router message: ";	$r61 = "";	goto [?= $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)];	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ");	if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r20 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$i4 = interfaceinvoke $r20.<java.util.List: int size()>();	$i5 = staticinvoke <java.lang.Math: int min(int,int)>(5, $i4);	$r22 = interfaceinvoke $r21.<java.util.List: java.util.List subList(int,int)>(0, $i5);	$r24 = interfaceinvoke $r22.<java.util.List: java.util.stream.Stream stream()>();	$r23 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getUrl__65: java.util.function.Function bootstrap$()>();	$r26 = interfaceinvoke $r24.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r23);	$r25 = staticinvoke <org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode$getAddress__73: java.util.function.Function bootstrap$()>();	$r28 = interfaceinvoke $r26.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r25);	$r27 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(",");	$r29 = interfaceinvoke $r28.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r27);	$r65 = (java.lang.String) $r29;	virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r31
;block_num 12