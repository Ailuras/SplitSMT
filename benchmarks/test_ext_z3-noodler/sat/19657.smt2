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

(declare-sort var2522 0)
(declare-sort var1790 0)
(declare-sort var2190 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getInterface/1741977347 (var2522) ClassObject)
(declare-fun append/-1031950772 (String var1790) String)
(declare-fun cast-from-ClassObject-to-var1790 (ClassObject) var1790)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/-945338117 (var2522) var2190)
(declare-fun getAddress/-2093578336 (var2190) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2522 var2522)
(declare-const null-var2190 var2190)
(declare-const var2025 var2522) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker 
(assert (not (= var2025 null-var2522)))
(define-const var3909 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3909)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3909!1 String)
(assert (= var3909!1 ""))
(assert true)
(define-const var3127 ClassObject (getInterface/1741977347 var2025)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var2251 String (append/-1031950772 var3909!1 (cast-from-ClassObject-to-var1790 var3127))) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3909!2 String)
(assert (str.prefixof var3909!1 var3909!2))
(assert true)
(define-const var2886 String (append/672562846 var2251 " -> ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var2251!1 String)
(assert (= var2251!1 (str.++ var2251 " -> ")))
(assert true)
(define-const var156 var2190 (getUrl/-945338117 var2025)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>() 
 ; Statement: if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (= var156 null-var2190))) ; Cond: $r4 != null 
(assert true)
(define-const var993 var2190 (getUrl/-945338117 var2025)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2566 String (getAddress/-2093578336 var993)) ; Statement: $r9 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var14 String (append/672562846 var2886 var2566)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var2886!1 String)
(assert (= var2886!1 (str.++ var2886 var2566)))
(assert true)
(define-const var2154 String (toString/-2075883882 var14)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getInterface/1741977347=([org.apache.dubbo.rpc.protocol.AbstractInvoker], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var1790=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2522=org.apache.dubbo.rpc.protocol.AbstractInvoker, var2025=r1, var3909=$r0, var3127=$r2, var1790=java.lang.Object, var2251=$r3, var2886=$r6, var2190=org.apache.dubbo.common.URL, var156=$r4, var993=$r5, var2566=$r9, var14=$r7, var2154=$r8}
; {org.apache.dubbo.rpc.protocol.AbstractInvoker=var2522, r1=var2025, $r0=var3909, $r2=var3127, java.lang.Object=var1790, $r3=var2251, $r6=var2886, org.apache.dubbo.common.URL=var2190, $r4=var156, $r5=var993, $r9=var2566, $r7=var14, $r8=var2154}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>();	if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>();	$r9 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3