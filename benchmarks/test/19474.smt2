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

(declare-sort var3492 0)
(declare-sort var431 0)
(declare-sort var3857 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getInterface/-178385660 (var3492) ClassObject)
(declare-fun append/-1031950772 (String var431) String)
(declare-fun cast-from-ClassObject-to-var431 (ClassObject) var431)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/1712233020 (var3492) var3857)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3492 var3492)
(declare-const null-var3857 var3857)
(declare-const var2691 var3492) ; Statement: r1 := @this: org.apache.dubbo.rpc.listener.ListenerInvokerWrapper 
(assert (not (= var2691 null-var3492)))
(define-const var1494 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1494)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1494!1 String)
(assert (= var1494!1 ""))
(assert true)
(define-const var1909 ClassObject (getInterface/-178385660 var2691)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: java.lang.Class getInterface()>() 
(assert true)
(define-const var3871 String (append/-1031950772 var1494!1 (cast-from-ClassObject-to-var431 var1909))) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1494!2 String)
(assert (str.prefixof var1494!1 var1494!2))
(assert true)
(define-const var3616 String (append/672562846 var3871 " -> ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3871!1 String)
(assert (= var3871!1 (str.++ var3871 " -> ")))
(assert true)
(define-const var2328 var3857 (getUrl/1712233020 var2691)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>() 
 ; Statement: if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>() 
(assert (not (not (= var2328 null-var3857)))) ; Negate: Cond: $r4 != null  
(define-const var1095 String " ") ; Statement: $r9 = " " 
 ; Statement: goto [?= $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1329 String (append/672562846 var3616 var1095)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var3616!1 String)
(assert (= var3616!1 (str.++ var3616 var1095)))
(assert true)
(define-const var479 String (toString/-2075883882 var1329)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getInterface/-178385660=([org.apache.dubbo.rpc.listener.ListenerInvokerWrapper], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var431=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/1712233020=([org.apache.dubbo.rpc.listener.ListenerInvokerWrapper], org.apache.dubbo.common.URL), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3492=org.apache.dubbo.rpc.listener.ListenerInvokerWrapper, var2691=r1, var1494=$r0, var1909=$r2, var431=java.lang.Object, var3871=$r3, var3616=$r6, var3857=org.apache.dubbo.common.URL, var2328=$r4, var1095=$r9, var1329=$r7, var479=$r8}
; {org.apache.dubbo.rpc.listener.ListenerInvokerWrapper=var3492, r1=var2691, $r0=var1494, $r2=var1909, java.lang.Object=var431, $r3=var3871, $r6=var3616, org.apache.dubbo.common.URL=var3857, $r4=var2328, $r9=var1095, $r7=var1329, $r8=var479}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.listener.ListenerInvokerWrapper;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r4 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>();	if $r4 != null goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.listener.ListenerInvokerWrapper: org.apache.dubbo.common.URL getUrl()>();	$r9 = " ";	goto [?= $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9)];	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3