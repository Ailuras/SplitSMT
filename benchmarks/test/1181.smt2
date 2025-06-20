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

(declare-sort var2358 0)
(declare-sort var312 0)
(declare-sort var2512 0)
(declare-sort var1782 0)
(declare-sort var3925 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-2070795087 (var2358) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun beforeSize/-2070795087 (var2358) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun nodeOutputSize/-2070795087 (var2358) Int)
(declare-fun chainOutputSize/-2070795087 (var2358) Int)
(declare-fun routerMessage/-2070795087 (var2358) String)
(declare-fun nodeOutputInvokers/-2070795087 (var2358) var2512)
(declare-fun var1782_isEmpty/73262611 (var3925) Bool)
(declare-fun cast-from-var2512-to-var3925 (var2512) var3925)
(declare-fun nextNode/-2070795087 (var2358) var2512)
(declare-fun var2512_iterator/-912451715 (var2512) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2358 var2358)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const null-var2512 var2512)
(declare-const var247 var2358) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode 
(assert (not (= var247 null-var2358)))
(declare-const var3299 Int) ; Statement: i3 := @parameter0: int 
(assert (not (= var3299 null-Int)))
(define-const var3022 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3022)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3022!1 String)
(assert (= var3022!1 ""))
(assert true)
(define-const var3063 String (append/672562846 var3022!1 "[ ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ") 
(declare-const var3022!2 String)
(assert (= var3022!2 (str.++ var3022!1 "[ ")))
(define-const var126 String (name/-2070795087 var247)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name> 
(assert true)
(define-const var2831 String (append/672562846 var3063 var126)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3063!1 String)
(assert (= var3063!1 (str.++ var3063 var126)))
(assert true)
(define-const var809 String (append/-1166366385 var2831 32)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2831!1 String)
(assert (str.prefixof var2831 var2831!1))
(assert true)
(define-const var3718 String (append/672562846 var809 "(Input: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ") 
(declare-const var809!1 String)
(assert (= var809!1 (str.++ var809 "(Input: ")))
(define-const var358 Int (beforeSize/-2070795087 var247)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize> 
(assert true)
(define-const var111 String (append/-1001720160 var3718 var358)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3718!1 String)
(assert (str.prefixof var3718 var3718!1))
(assert true)
(define-const var1300 String (append/672562846 var111 ") ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var111!1 String)
(assert (= var111!1 (str.++ var111 ") ")))
(assert true)
(define-const var1274 String (append/672562846 var1300 "(Current Node Output: ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ") 
(declare-const var1300!1 String)
(assert (= var1300!1 (str.++ var1300 "(Current Node Output: ")))
(define-const var2996 Int (nodeOutputSize/-2070795087 var247)) ; Statement: $i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize> 
(assert true)
(define-const var794 String (append/-1001720160 var1274 var2996)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var1274!1 String)
(assert (str.prefixof var1274 var1274!1))
(assert true)
(define-const var1484 String (append/672562846 var794 ") ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var794!1 String)
(assert (= var794!1 (str.++ var794 ") ")))
(assert true)
(define-const var3290 String (append/672562846 var1484 "(Chain Node Output: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ") 
(declare-const var1484!1 String)
(assert (= var1484!1 (str.++ var1484 "(Chain Node Output: ")))
(define-const var1917 Int (chainOutputSize/-2070795087 var247)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize> 
(assert true)
(define-const var2423 String (append/-1001720160 var3290 var1917)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var3290!1 String)
(assert (str.prefixof var3290 var3290!1))
(assert true)
(define-const var3685 String (append/-1166366385 var2423 41)) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var2423!1 String)
(assert (str.prefixof var2423 var2423!1))
(define-const var2591 String (routerMessage/-2070795087 var247)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r14 != null goto $r61 = " Router message: " 
(assert (not (not (= var2591 null-String)))) ; Negate: Cond: $r14 != null  
(define-const var1153 String "") ; Statement: $r61 = "" 
 ; Statement: goto [?= $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1368 String (append/672562846 var3685 var1153)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var3685!1 String)
(assert (= var3685!1 (str.++ var3685 var1153)))
(define-const var2749 String (routerMessage/-2070795087 var247)) ; Statement: $r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert (not (not (= var2749 null-String)))) ; Negate: Cond: $r16 != null  
(define-const var2328 String "") ; Statement: $r62 = "" 
 ; Statement: goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2113 String (append/672562846 var1368 var2328)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var1368!1 String)
(assert (= var1368!1 (str.++ var1368 var2328)))
(assert true)
;(assert (append/672562846 var2113 " ] ")) ; Statement: virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ") 
(declare-const var2113!1 String)
(assert (= var2113!1 (str.++ var2113 " ] ")))
 ; Statement: if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(assert (not (= var3299 1))) ; Cond: i3 != 1 
(assert true)
(define-const var494 String (append/672562846 var3022!2 "Current Node Output: ")) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(declare-const var3022!3 String)
(assert (= var3022!3 (str.++ var3022!2 "Current Node Output: ")))
(define-const var243 var2512 (nodeOutputInvokers/-2070795087 var247)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var1808 Bool (var1782_isEmpty/73262611 (cast-from-var2512-to-var3925 var243))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(assert (not (= (ite var1808 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3585 String "Empty") ; Statement: $r65 = "Empty" 
 ; Statement: goto [?= virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65)] 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var494 var3585)) ; Statement: virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var494!1 String)
(assert (= var494!1 (str.++ var494 var3585)))
(assert true) ; Non Conditional
(define-const var911 var2512 (nodeOutputInvokers/-2070795087 var247)) ; Statement: $r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
 ; Statement: if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(assert (= var911 null-var2512)) ; Cond: $r66 == null 
(define-const var2429 var2512 (nextNode/-2070795087 var247)) ; Statement: $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(define-const var1218 Iterator (var2512_iterator/-912451715 var2429)) ; Statement: $r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var263 Bool (Iterator_hasNext/-1669924200 var1218)) ; Statement: $z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var263 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var292 String (toString/-2075883882 var3022!3)) ; Statement: $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), beforeSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), nodeOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), chainOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), routerMessage/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), nodeOutputInvokers/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var1782_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var2512-to-var3925=([java.util.List], java.util.Collection), nextNode/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var2512_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2358=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode, var247=r1, var3299=i3, var3022=$r0, var3063=$r3, var126=$r2, var2831=$r4, var809=$r5, var3718=$r6, var358=$i0, var111=$r7, var1300=$r8, var1274=$r9, var2996=$i1, var794=$r10, var1484=$r11, var3290=$r12, var1917=$i2, var2423=$r13, var3685=$r15, var2591=$r14, var312=null_type, var1153=$r61, var1368=$r17, var2749=$r16, var2328=$r62, var2113=$r18, var494=$r30, var2512=java.util.List, var243=$r19, var1782=org.apache.dubbo.common.utils.CollectionUtils, var3925=java.util.Collection, var1808=$z0, var3585=$r65, var911=$r66, var2429=$r67, var1218=$r68, var263=$z3, var292=$r31}
; {org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode=var2358, r1=var247, i3=var3299, $r0=var3022, $r3=var3063, $r2=var126, $r4=var2831, $r5=var809, $r6=var3718, $i0=var358, $r7=var111, $r8=var1300, $r9=var1274, $i1=var2996, $r10=var794, $r11=var1484, $r12=var3290, $i2=var1917, $r13=var2423, $r15=var3685, $r14=var2591, null_type=var312, $r61=var1153, $r17=var1368, $r16=var2749, $r62=var2328, $r18=var2113, $r30=var494, java.util.List=var2512, $r19=var243, org.apache.dubbo.common.utils.CollectionUtils=var1782, java.util.Collection=var3925, $z0=var1808, $r65=var3585, $r66=var911, $r67=var2429, $r68=var1218, $z3=var263, $r31=var292}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode;	i3 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ");	$i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ");	$i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r14 != null goto $r61 = " Router message: ";	$r61 = "";	goto [?= $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)];	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r62 = "";	goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62)];	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ");	if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r65 = "Empty";	goto [?= virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65)];	virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r31
;block_num 12