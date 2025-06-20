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

(declare-sort var1016 0)
(declare-sort var3185 0)
(declare-sort var994 0)
(declare-sort var402 0)
(declare-sort var987 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-2070795087 (var1016) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun beforeSize/-2070795087 (var1016) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun nodeOutputSize/-2070795087 (var1016) Int)
(declare-fun chainOutputSize/-2070795087 (var1016) Int)
(declare-fun routerMessage/-2070795087 (var1016) String)
(declare-fun nodeOutputInvokers/-2070795087 (var1016) var994)
(declare-fun var402_isEmpty/73262611 (var987) Bool)
(declare-fun cast-from-var994-to-var987 (var994) var987)
(declare-fun nextNode/-2070795087 (var1016) var994)
(declare-fun var994_iterator/-912451715 (var994) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1016 var1016)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const null-var994 var994)
(declare-const var818 var1016) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode 
(assert (not (= var818 null-var1016)))
(declare-const var1804 Int) ; Statement: i3 := @parameter0: int 
(assert (not (= var1804 null-Int)))
(define-const var1605 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1605)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1605!1 String)
(assert (= var1605!1 ""))
(assert true)
(define-const var3252 String (append/672562846 var1605!1 "[ ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ") 
(declare-const var1605!2 String)
(assert (= var1605!2 (str.++ var1605!1 "[ ")))
(define-const var1117 String (name/-2070795087 var818)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name> 
(assert true)
(define-const var532 String (append/672562846 var3252 var1117)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3252!1 String)
(assert (= var3252!1 (str.++ var3252 var1117)))
(assert true)
(define-const var876 String (append/-1166366385 var532 32)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var532!1 String)
(assert (str.prefixof var532 var532!1))
(assert true)
(define-const var789 String (append/672562846 var876 "(Input: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ") 
(declare-const var876!1 String)
(assert (= var876!1 (str.++ var876 "(Input: ")))
(define-const var2942 Int (beforeSize/-2070795087 var818)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize> 
(assert true)
(define-const var62 String (append/-1001720160 var789 var2942)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var789!1 String)
(assert (str.prefixof var789 var789!1))
(assert true)
(define-const var2665 String (append/672562846 var62 ") ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var62!1 String)
(assert (= var62!1 (str.++ var62 ") ")))
(assert true)
(define-const var2700 String (append/672562846 var2665 "(Current Node Output: ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ") 
(declare-const var2665!1 String)
(assert (= var2665!1 (str.++ var2665 "(Current Node Output: ")))
(define-const var2606 Int (nodeOutputSize/-2070795087 var818)) ; Statement: $i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize> 
(assert true)
(define-const var1282 String (append/-1001720160 var2700 var2606)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var2700!1 String)
(assert (str.prefixof var2700 var2700!1))
(assert true)
(define-const var2426 String (append/672562846 var1282 ") ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var1282!1 String)
(assert (= var1282!1 (str.++ var1282 ") ")))
(assert true)
(define-const var248 String (append/672562846 var2426 "(Chain Node Output: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ") 
(declare-const var2426!1 String)
(assert (= var2426!1 (str.++ var2426 "(Chain Node Output: ")))
(define-const var3373 Int (chainOutputSize/-2070795087 var818)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize> 
(assert true)
(define-const var931 String (append/-1001720160 var248 var3373)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var248!1 String)
(assert (str.prefixof var248 var248!1))
(assert true)
(define-const var3015 String (append/-1166366385 var931 41)) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var931!1 String)
(assert (str.prefixof var931 var931!1))
(define-const var2902 String (routerMessage/-2070795087 var818)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r14 != null goto $r61 = " Router message: " 
(assert (not (not (= var2902 null-String)))) ; Negate: Cond: $r14 != null  
(define-const var1575 String "") ; Statement: $r61 = "" 
 ; Statement: goto [?= $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)] 
(assert true) ; Non Conditional
(assert true)
(define-const var211 String (append/672562846 var3015 var1575)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var3015!1 String)
(assert (= var3015!1 (str.++ var3015 var1575)))
(define-const var3946 String (routerMessage/-2070795087 var818)) ; Statement: $r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert (not (= var3946 null-String))) ; Cond: $r16 != null 
(define-const var1505 String (routerMessage/-2070795087 var818)) ; Statement: $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert true) ; Non Conditional
(assert true)
(define-const var2393 String (append/672562846 var211 var1505)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var211!1 String)
(assert (= var211!1 (str.++ var211 var1505)))
(assert true)
;(assert (append/672562846 var2393 " ] ")) ; Statement: virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ") 
(declare-const var2393!1 String)
(assert (= var2393!1 (str.++ var2393 " ] ")))
 ; Statement: if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(assert (not (= var1804 1))) ; Cond: i3 != 1 
(assert true)
(define-const var1368 String (append/672562846 var1605!2 "Current Node Output: ")) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(declare-const var1605!3 String)
(assert (= var1605!3 (str.++ var1605!2 "Current Node Output: ")))
(define-const var2687 var994 (nodeOutputInvokers/-2070795087 var818)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var3338 Bool (var402_isEmpty/73262611 (cast-from-var994-to-var987 var2687))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(assert (not (= (ite var3338 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1531 String "Empty") ; Statement: $r65 = "Empty" 
 ; Statement: goto [?= virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65)] 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var1368 var1531)) ; Statement: virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var1368!1 String)
(assert (= var1368!1 (str.++ var1368 var1531)))
(assert true) ; Non Conditional
(define-const var216 var994 (nodeOutputInvokers/-2070795087 var818)) ; Statement: $r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
 ; Statement: if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(assert (= var216 null-var994)) ; Cond: $r66 == null 
(define-const var852 var994 (nextNode/-2070795087 var818)) ; Statement: $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(define-const var35 Iterator (var994_iterator/-912451715 var852)) ; Statement: $r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1530 Bool (Iterator_hasNext/-1669924200 var35)) ; Statement: $z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var1530 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var901 String (toString/-2075883882 var1605!3)) ; Statement: $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), beforeSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), nodeOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), chainOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), routerMessage/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), nodeOutputInvokers/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var402_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var994-to-var987=([java.util.List], java.util.Collection), nextNode/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var994_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1016=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode, var818=r1, var1804=i3, var1605=$r0, var3252=$r3, var1117=$r2, var532=$r4, var876=$r5, var789=$r6, var2942=$i0, var62=$r7, var2665=$r8, var2700=$r9, var2606=$i1, var1282=$r10, var2426=$r11, var248=$r12, var3373=$i2, var931=$r13, var3015=$r15, var2902=$r14, var3185=null_type, var1575=$r61, var211=$r17, var3946=$r16, var1505=$r62, var2393=$r18, var1368=$r30, var994=java.util.List, var2687=$r19, var402=org.apache.dubbo.common.utils.CollectionUtils, var987=java.util.Collection, var3338=$z0, var1531=$r65, var216=$r66, var852=$r67, var35=$r68, var1530=$z3, var901=$r31}
; {org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode=var1016, r1=var818, i3=var1804, $r0=var1605, $r3=var3252, $r2=var1117, $r4=var532, $r5=var876, $r6=var789, $i0=var2942, $r7=var62, $r8=var2665, $r9=var2700, $i1=var2606, $r10=var1282, $r11=var2426, $r12=var248, $i2=var3373, $r13=var931, $r15=var3015, $r14=var2902, null_type=var3185, $r61=var1575, $r17=var211, $r16=var3946, $r62=var1505, $r18=var2393, $r30=var1368, java.util.List=var994, $r19=var2687, org.apache.dubbo.common.utils.CollectionUtils=var402, java.util.Collection=var987, $z0=var3338, $r65=var1531, $r66=var216, $r67=var852, $r68=var35, $z3=var1530, $r31=var901}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode;	i3 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ");	$i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ");	$i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r14 != null goto $r61 = " Router message: ";	$r61 = "";	goto [?= $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)];	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ");	if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r65 = "Empty";	goto [?= virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65)];	virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r31
;block_num 12