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

(declare-sort var2858 0)
(declare-sort var967 0)
(declare-sort var1272 0)
(declare-sort var2785 0)
(declare-sort var864 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-2070795087 (var2858) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun beforeSize/-2070795087 (var2858) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun nodeOutputSize/-2070795087 (var2858) Int)
(declare-fun chainOutputSize/-2070795087 (var2858) Int)
(declare-fun routerMessage/-2070795087 (var2858) String)
(declare-fun nodeOutputInvokers/-2070795087 (var2858) var1272)
(declare-fun var2785_isEmpty/73262611 (var864) Bool)
(declare-fun cast-from-var1272-to-var864 (var1272) var864)
(declare-fun nextNode/-2070795087 (var2858) var1272)
(declare-fun var1272_iterator/-912451715 (var1272) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2858 var2858)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const null-var1272 var1272)
(declare-const var3495 var2858) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode 
(assert (not (= var3495 null-var2858)))
(declare-const var2438 Int) ; Statement: i3 := @parameter0: int 
(assert (not (= var2438 null-Int)))
(define-const var417 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var417)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var417!1 String)
(assert (= var417!1 ""))
(assert true)
(define-const var122 String (append/672562846 var417!1 "[ ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ") 
(declare-const var417!2 String)
(assert (= var417!2 (str.++ var417!1 "[ ")))
(define-const var3995 String (name/-2070795087 var3495)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name> 
(assert true)
(define-const var2880 String (append/672562846 var122 var3995)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var122!1 String)
(assert (= var122!1 (str.++ var122 var3995)))
(assert true)
(define-const var3214 String (append/-1166366385 var2880 32)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2880!1 String)
(assert (str.prefixof var2880 var2880!1))
(assert true)
(define-const var2849 String (append/672562846 var3214 "(Input: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ") 
(declare-const var3214!1 String)
(assert (= var3214!1 (str.++ var3214 "(Input: ")))
(define-const var1453 Int (beforeSize/-2070795087 var3495)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize> 
(assert true)
(define-const var1210 String (append/-1001720160 var2849 var1453)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var2849!1 String)
(assert (str.prefixof var2849 var2849!1))
(assert true)
(define-const var342 String (append/672562846 var1210 ") ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var1210!1 String)
(assert (= var1210!1 (str.++ var1210 ") ")))
(assert true)
(define-const var2641 String (append/672562846 var342 "(Current Node Output: ")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ") 
(declare-const var342!1 String)
(assert (= var342!1 (str.++ var342 "(Current Node Output: ")))
(define-const var3558 Int (nodeOutputSize/-2070795087 var3495)) ; Statement: $i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize> 
(assert true)
(define-const var2437 String (append/-1001720160 var2641 var3558)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var2641!1 String)
(assert (str.prefixof var2641 var2641!1))
(assert true)
(define-const var1111 String (append/672562846 var2437 ") ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var2437!1 String)
(assert (= var2437!1 (str.++ var2437 ") ")))
(assert true)
(define-const var976 String (append/672562846 var1111 "(Chain Node Output: ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ") 
(declare-const var1111!1 String)
(assert (= var1111!1 (str.++ var1111 "(Chain Node Output: ")))
(define-const var1190 Int (chainOutputSize/-2070795087 var3495)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize> 
(assert true)
(define-const var2611 String (append/-1001720160 var976 var1190)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var976!1 String)
(assert (str.prefixof var976 var976!1))
(assert true)
(define-const var2425 String (append/-1166366385 var2611 41)) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var2611!1 String)
(assert (str.prefixof var2611 var2611!1))
(define-const var1074 String (routerMessage/-2070795087 var3495)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r14 != null goto $r61 = " Router message: " 
(assert (not (= var1074 null-String))) ; Cond: $r14 != null 
(define-const var3154 String " Router message: ") ; Statement: $r61 = " Router message: " 
(assert true) ; Non Conditional
(assert true)
(define-const var2651 String (append/672562846 var2425 var3154)) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var2425!1 String)
(assert (= var2425!1 (str.++ var2425 var3154)))
(define-const var1733 String (routerMessage/-2070795087 var3495)) ; Statement: $r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
 ; Statement: if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage> 
(assert (not (not (= var1733 null-String)))) ; Negate: Cond: $r16 != null  
(define-const var247 String "") ; Statement: $r62 = "" 
 ; Statement: goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1459 String (append/672562846 var2651 var247)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62) 
(declare-const var2651!1 String)
(assert (= var2651!1 (str.++ var2651 var247)))
(assert true)
;(assert (append/672562846 var1459 " ] ")) ; Statement: virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ") 
(declare-const var1459!1 String)
(assert (= var1459!1 (str.++ var1459 " ] ")))
 ; Statement: if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(assert (not (= var2438 1))) ; Cond: i3 != 1 
(assert true)
(define-const var808 String (append/672562846 var417!2 "Current Node Output: ")) ; Statement: $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ") 
(declare-const var417!3 String)
(assert (= var417!3 (str.++ var417!2 "Current Node Output: ")))
(define-const var3061 var1272 (nodeOutputInvokers/-2070795087 var3495)) ; Statement: $r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(define-const var1343 Bool (var2785_isEmpty/73262611 (cast-from-var1272-to-var864 var3061))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
(assert (not (= (ite var1343 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2115 String "Empty") ; Statement: $r65 = "Empty" 
 ; Statement: goto [?= virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65)] 
(assert true) ; Non Conditional
(assert true)
;(assert (append/672562846 var808 var2115)) ; Statement: virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65) 
(declare-const var808!1 String)
(assert (= var808!1 (str.++ var808 var2115)))
(assert true) ; Non Conditional
(define-const var1314 var1272 (nodeOutputInvokers/-2070795087 var3495)) ; Statement: $r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers> 
 ; Statement: if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(assert (= var1314 null-var1272)) ; Cond: $r66 == null 
(define-const var2763 var1272 (nextNode/-2070795087 var3495)) ; Statement: $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode> 
(define-const var2219 Iterator (var1272_iterator/-912451715 var2763)) ; Statement: $r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3940 Bool (Iterator_hasNext/-1669924200 var2219)) ; Statement: $z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3940 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var3005 String (toString/-2075883882 var417!3)) ; Statement: $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r31 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), beforeSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), nodeOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), chainOutputSize/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], int), routerMessage/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.lang.String), nodeOutputInvokers/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var2785_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var1272-to-var864=([java.util.List], java.util.Collection), nextNode/-2070795087=([org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode], java.util.List), var1272_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2858=org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode, var3495=r1, var2438=i3, var417=$r0, var122=$r3, var3995=$r2, var2880=$r4, var3214=$r5, var2849=$r6, var1453=$i0, var1210=$r7, var342=$r8, var2641=$r9, var3558=$i1, var2437=$r10, var1111=$r11, var976=$r12, var1190=$i2, var2611=$r13, var2425=$r15, var1074=$r14, var967=null_type, var3154=$r61, var2651=$r17, var1733=$r16, var247=$r62, var1459=$r18, var808=$r30, var1272=java.util.List, var3061=$r19, var2785=org.apache.dubbo.common.utils.CollectionUtils, var864=java.util.Collection, var1343=$z0, var2115=$r65, var1314=$r66, var2763=$r67, var2219=$r68, var3940=$z3, var3005=$r31}
; {org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode=var2858, r1=var3495, i3=var2438, $r0=var417, $r3=var122, $r2=var3995, $r4=var2880, $r5=var3214, $r6=var2849, $i0=var1453, $r7=var1210, $r8=var342, $r9=var2641, $i1=var3558, $r10=var2437, $r11=var1111, $r12=var976, $i2=var1190, $r13=var2611, $r15=var2425, $r14=var1074, null_type=var967, $r61=var3154, $r17=var2651, $r16=var1733, $r62=var247, $r18=var1459, $r30=var808, java.util.List=var1272, $r19=var3061, org.apache.dubbo.common.utils.CollectionUtils=var2785, java.util.Collection=var864, $z0=var1343, $r65=var2115, $r66=var1314, $r67=var2763, $r68=var2219, $z3=var3940, $r31=var3005}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode;	i3 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[ ");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Input: ");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int beforeSize>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Current Node Output: ");	$i1 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int nodeOutputSize>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(Chain Node Output: ");	$i2 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: int chainOutputSize>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r14 != null goto $r61 = " Router message: ";	$r61 = " Router message: ";	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r16 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	if $r16 != null goto $r62 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.lang.String routerMessage>;	$r62 = "";	goto [?= $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62)];	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r62);	virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ] ");	if i3 != 1 goto $r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r30 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Current Node Output: ");	$r19 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z0 == 0 goto $r21 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	$r65 = "Empty";	goto [?= virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65)];	virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r65);	$r66 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nodeOutputInvokers>;	if $r66 == null goto $r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r67 = r1.<org.apache.dubbo.rpc.cluster.router.RouterSnapshotNode: java.util.List nextNode>;	$r68 = interfaceinvoke $r67.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke $r68.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto $r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r31 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r31
;block_num 12