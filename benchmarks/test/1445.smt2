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

(declare-sort var1870 0)
(declare-sort var573 0)
(declare-sort var3648 0)
(declare-sort var1670 0)
(declare-sort var969 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-2070795087 (var1870) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun beforeSize/-2070795087 (var1870) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun nodeOutputSize/-2070795087 (var1870) Int)
(declare-fun chainOutputSize/-2070795087 (var1870) Int)
(declare-fun routerMessage/-2070795087 (var1870) String)
(declare-fun nodeOutputInvokers/-2070795087 (var1870) var3648)
(declare-fun var1670_isEmpty/73262611 (var969) Bool)
(declare-fun cast-from-var3648-to-var969 (var3648) var969)
(declare-fun nextNode/-2070795087 (var1870) var3648)
(declare-fun var3648_iterator/-912451715 (var3648) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1870 var1870)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const null-var3648 var3648)
(declare-const var2546 var1870) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode 
(assert (not (= var2546 null-var1870)))
(declare-const var2686 Int) ; Statement: i3 := @parameter0: int 
(assert (not (= var2686 null-Int)))
(define-const var3178 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3178)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3178!1 String)
(assert (= var3178!1 ""))
(assert true)
(define-const var2920 String (append/672562846 var3178!1 "[ ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ") 
(declare-const var3178!2 String)
(assert (= var3178!2 (str.++ var3178!1 "[ ")))
(define-const var1726 String (name/-2070795087 var2546)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name> 
(assert true)
(define-const var1568 String (append/672562846 var2920 var1726)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2920!1 String)
(assert (= var2920!1 (str.++ var2920 var1726)))
(assert true)
(define-const var779 String (append/-1166366385 var1568 32)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var1568!1 String)
(assert (str.prefixof var1568 var1568!1))
(assert true)
(define-const var2287 String (append/672562846 var779 "(Input: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ") 
(declare-const var779!1 String)
(assert (= var779!1 (str.++ var779 "(Input: ")))
(define-const var1703 Int (beforeSize/-2070795087 var2546)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize> 
(assert true)
(define-const var1519 String (append/-1001720160 var2287 var1703)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var2287!1 String)
(assert (str.prefixof var2287 var2287!1))
(assert true)
(define-const var3230 String (append/672562846 var1519 ") ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var1519!1 String)
(assert (= var1519!1 (str.++ var1519 ") ")))
(assert true)
(define-const var2738 String (append/672562846 var3230 "(Current Node Output: ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ") 
(declare-const var3230!1 String)
(assert (= var3230!1 (str.++ var3230 "(Current Node Output: ")))
(define-const var752 Int (nodeOutputSize/-2070795087 var2546)) ; Statement: $i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize> 
(assert true)
(define-const var185 String (append/-1001720160 var2738 var752)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var2738!1 String)
(assert (str.prefixof var2738 var2738!1))
(assert true)
(define-const var3993 String (append/672562846 var185 ") ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var185!1 String)
(assert (= var185!1 (str.++ var185 ") ")))
(assert true)
(define-const var3676 String (append/672562846 var3993 "(Chain Node Output: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ") 
(declare-const var3993!1 String)
(assert (= var3993!1 (str.++ var3993 "(Chain Node Output: ")))
(define-const var702 Int (chainOutputSize/-2070795087 var2546)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize> 
(assert true)
(define-const var1976 String (append/-1001720160 var3676 var702)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var3676!1 String)
(assert (str.prefixof var3676 var3676!1))
(assert true)
(define-const var62 String (append/-1166366385 var1976 41)) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var1976!1 String)
(assert (str.prefixof var1976 var1976!1))
(define-const var536 String (routerMessage/-2070795087 var2546)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r14 != null goto $r61 = " Router message: " 
(assert (not (= var536 null-String))) ; Cond: $r14 != null 
(define-const var629 String " Router message: ") ; Statement: $r61 = " Router message: " 
(assert true) ; Non Conditional
(assert true)
(define-const var1961 String (append/672562846 var62 var629)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var62!1 String)
(assert (= var62!1 (str.++ var62 var629)))
(define-const var800 String (routerMessage/-2070795087 var2546)) ; Statement: $r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert (not (= var800 null-String))) ; Cond: $r16 != null 
(define-const var3865 String (routerMessage/-2070795087 var2546)) ; Statement: $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert true) ; Non Conditional
(assert true)
(define-const var3986 String (append/672562846 var1961 var3865)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var1961!1 String)
(assert (= var1961!1 (str.++ var1961 var3865)))
(assert true)
;(assert (append/672562846 var3986 " ] ")) ; Statement: virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ") 
(declare-const var3986!1 String)
(assert (= var3986!1 (str.++ var3986 " ] ")))
 ; Statement: if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(assert (not (= var2686 1))) ; Cond: i3 != 1 
(assert true)
(define-const var964 String (append/672562846 var3178!2 "Current Node Output: ")) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(declare-const var3178!3 String)
(assert (= var3178!3 (str.++ var3178!2 "Current Node Output: ")))
(define-const var1278 var3648 (nodeOutputInvokers/-2070795087 var2546)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var98 Bool (var1670_isEmpty/73262611 (cast-from-var3648-to-var969 var1278))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(assert (not (= (ite var98 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2075 String "Empty") ; Statement: $r65 = "Empty" 
 ; Statement: goto [?= virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65)] 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var964 var2075)) ; Statement: virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var964!1 String)
(assert (= var964!1 (str.++ var964 var2075)))
(assert true) ; Non Conditional
(define-const var3433 var3648 (nodeOutputInvokers/-2070795087 var2546)) ; Statement: $r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
 ; Statement: if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(assert (= var3433 null-var3648)) ; Cond: $r66 == null 
(define-const var3866 var3648 (nextNode/-2070795087 var2546)) ; Statement: $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(define-const var377 Iterator (var3648_iterator/-912451715 var3866)) ; Statement: $r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2612 Bool (Iterator_hasNext/-1669924200 var377)) ; Statement: $z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2612 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var1994 String (toString/-2075883882 var3178!3)) ; Statement: $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), beforeSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), nodeOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), chainOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), routerMessage/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), nodeOutputInvokers/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var1670_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var3648-to-var969=([java.util.List], java.util.Collection), nextNode/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var3648_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1870=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode, var2546=r1, var2686=i3, var3178=$r0, var2920=$r3, var1726=$r2, var1568=$r4, var779=$r5, var2287=$r6, var1703=$i0, var1519=$r7, var3230=$r8, var2738=$r9, var752=$i1, var185=$r10, var3993=$r11, var3676=$r12, var702=$i2, var1976=$r13, var62=$r15, var536=$r14, var573=null_type, var629=$r61, var1961=$r17, var800=$r16, var3865=$r62, var3986=$r18, var964=$r30, var3648=java.util.List, var1278=$r19, var1670=org.apache.dubbo.common.utils.CollectionUtils, var969=java.util.Collection, var98=$z0, var2075=$r65, var3433=$r66, var3866=$r67, var377=$r68, var2612=$z3, var1994=$r31}
; {org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode=var1870, r1=var2546, i3=var2686, $r0=var3178, $r3=var2920, $r2=var1726, $r4=var1568, $r5=var779, $r6=var2287, $i0=var1703, $r7=var1519, $r8=var3230, $r9=var2738, $i1=var752, $r10=var185, $r11=var3993, $r12=var3676, $i2=var702, $r13=var1976, $r15=var62, $r14=var536, null_type=var573, $r61=var629, $r17=var1961, $r16=var800, $r62=var3865, $r18=var3986, $r30=var964, java.util.List=var3648, $r19=var1278, org.apache.dubbo.common.utils.CollectionUtils=var1670, java.util.Collection=var969, $z0=var98, $r65=var2075, $r66=var3433, $r67=var3866, $r68=var377, $z3=var2612, $r31=var1994}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode;	i3 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ");	$i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ");	$i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r14 != null goto $r61 = " Router message: ";	$r61 = " Router message: ";	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ");	if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r65 = "Empty";	goto [?= virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65)];	virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r31
;block_num 12