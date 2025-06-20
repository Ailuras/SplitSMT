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

(declare-sort var1767 0)
(declare-sort var3504 0)
(declare-sort var1423 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getInterface/1741977347 (var1767) ClassObject)
(declare-fun append/-1031950772 (String var3504) String)
(declare-fun cast-from-ClassObject-to-var3504 (ClassObject) var3504)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/-945338117 (var1767) var1423)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1767 var1767)
(declare-const null-var1423 var1423)
(declare-const var3090 var1767) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker 
(assert (not (= var3090 null-var1767)))
(define-const var3992 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3992)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3992!1 String)
(assert (= var3992!1 ""))
(assert true)
(define-const var3634 ClassObject (getInterface/1741977347 var3090)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var2460 String (append/-1031950772 var3992!1 (cast-from-ClassObject-to-var3504 var3634))) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3992!2 String)
(assert (str.prefixof var3992!1 var3992!2))
(assert true)
(define-const var3275 String (append/672562846 var2460 " -> ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var2460!1 String)
(assert (= var2460!1 (str.++ var2460 " -> ")))
(assert true)
(define-const var2899 var1423 (getUrl/-945338117 var3090)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>() 
 ; Statement: if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (not (= var2899 null-var1423)))) ; Negate: Cond: $r4 != null  
(define-const var274 String "") ; Statement: $r9 = "" 
 ; Statement: goto [?= $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2476 String (append/672562846 var3275 var274)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var3275!1 String)
(assert (= var3275!1 (str.++ var3275 var274)))
(assert true)
(define-const var1223 String (toString/-2075883882 var2476)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getInterface/1741977347=([org.apache.dubbo.rpc.protocol.AbstractInvoker], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3504=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1767=org.apache.dubbo.rpc.protocol.AbstractInvoker, var3090=r1, var3992=$r0, var3634=$r2, var3504=java.lang.Object, var2460=$r3, var3275=$r6, var1423=org.apache.dubbo.common.URL, var2899=$r4, var274=$r9, var2476=$r7, var1223=$r8}
; {org.apache.dubbo.rpc.protocol.AbstractInvoker=var1767, r1=var3090, $r0=var3992, $r2=var3634, java.lang.Object=var3504, $r3=var2460, $r6=var3275, org.apache.dubbo.common.URL=var1423, $r4=var2899, $r9=var274, $r7=var2476, $r8=var1223}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>();	if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>();	$r9 = "";	goto [?= $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9)];	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3