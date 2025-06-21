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

(declare-sort var2738 0)
(declare-sort var2901 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toFullString/-798704221 (var2901) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun multicast/132386392 (var2738 String) void)
(declare-const null-var2738 var2738)
(declare-const null-var2901 var2901)
(declare-const var2958 var2738) ; Statement: r0 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry 
(assert (not (= var2958 null-var2738)))
(declare-const var1281 var2901) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1281 null-var2901)))
(define-const var527 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var527)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var527!1 String)
(assert (= var527!1 ""))
(assert true)
(define-const var1579 String (append/672562846 var527!1 "register ")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("register ") 
(declare-const var527!2 String)
(assert (= var527!2 (str.++ var527!1 "register ")))
(assert true)
(define-const var3400 String (toFullString/-798704221 var1281)) ; Statement: $r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var805 String (append/672562846 var1579 var3400)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1579!1 String)
(assert (= var1579!1 (str.++ var1579 var3400)))
(assert true)
(define-const var2505 String (toString/-2075883882 var805)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (multicast/132386392 var2958 var2505)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.multicast.MulticastRegistry: void multicast(java.lang.String)>($r6) 

(declare-const var2958!1 var2738)
(declare-const var2505!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), multicast/132386392=([org.apache.dubbo.registry.multicast.MulticastRegistry, java.lang.String], void)}
; {var2738=org.apache.dubbo.registry.multicast.MulticastRegistry, var2958=r0, var2901=org.apache.dubbo.common.URL, var1281=r2, var527=$r1, var1579=$r4, var3400=$r3, var805=$r5, var2505=$r6}
; {org.apache.dubbo.registry.multicast.MulticastRegistry=var2738, r0=var2958, org.apache.dubbo.common.URL=var2901, r2=var1281, $r1=var527, $r4=var1579, $r3=var3400, $r5=var805, $r6=var2505}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("register ");	$r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r0.<org.apache.dubbo.registry.multicast.MulticastRegistry: void multicast(java.lang.String)>($r6);	return
;block_num 1