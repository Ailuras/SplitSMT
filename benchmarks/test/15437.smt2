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

(declare-sort var1036 0)
(declare-sort var1938 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toFullString/-798704221 (var1938) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun multicast/132386392 (var1036 String) void)
(declare-const null-var1036 var1036)
(declare-const null-var1938 var1938)
(declare-const var1476 var1036) ; Statement: r0 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry 
(assert (not (= var1476 null-var1036)))
(declare-const var1598 var1938) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1598 null-var1938)))
(define-const var9 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var9)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var9!1 String)
(assert (= var9!1 ""))
(assert true)
(define-const var1116 String (append/672562846 var9!1 "unregister ")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unregister ") 
(declare-const var9!2 String)
(assert (= var9!2 (str.++ var9!1 "unregister ")))
(assert true)
(define-const var2092 String (toFullString/-798704221 var1598)) ; Statement: $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var1786 String (append/672562846 var1116 var2092)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1116!1 String)
(assert (= var1116!1 (str.++ var1116 var2092)))
(assert true)
(define-const var1919 String (toString/-2075883882 var1786)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (multicast/132386392 var1476 var1919)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.multicast.MulticastRegistry: void multicast(java.lang.String)>($r6) 

(declare-const var1476!1 var1036)
(declare-const var1919!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), multicast/132386392=([org.apache.dubbo.registry.multicast.MulticastRegistry, java.lang.String], void)}
; {var1036=org.apache.dubbo.registry.multicast.MulticastRegistry, var1476=r0, var1938=org.apache.dubbo.common.URL, var1598=r2, var9=$r1, var1116=$r4, var2092=$r3, var1786=$r5, var1919=$r6}
; {org.apache.dubbo.registry.multicast.MulticastRegistry=var1036, r0=var1476, org.apache.dubbo.common.URL=var1938, r2=var1598, $r1=var9, $r4=var1116, $r3=var2092, $r5=var1786, $r6=var1919}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unregister ");	$r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r0.<org.apache.dubbo.registry.multicast.MulticastRegistry: void multicast(java.lang.String)>($r6);	return
;block_num 1