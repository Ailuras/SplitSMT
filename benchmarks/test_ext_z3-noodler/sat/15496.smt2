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

(declare-sort var312 0)
(declare-sort var888 0)
(declare-sort var797 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceInterface/-1311863806 (var888) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toFullString/-798704221 (var888) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun multicast/132386392 (var312 String) void)
(declare-const null-var312 var312)
(declare-const null-var888 var888)
(declare-const null-var797 var797)
(declare-const var3422 var312) ; Statement: r3 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry 
(assert (not (= var3422 null-var312)))
(declare-const var1902 var888) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1902 null-var888)))
(declare-const var828 var797) ; Statement: r4 := @parameter1: org.apache.dubbo.registry.NotifyListener 
(assert (not (= var828 null-var797)))
(define-const var3857 String "*") ; Statement: $r2 = "*" 
(assert true)
(define-const var3731 String (getServiceInterface/-1311863806 var1902)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var3900 Bool (= var3857 var3731)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r5 = new java.lang.StringBuilder 
(assert (not (= (ite var3900 1 0) 0))) ; Cond: $z0 != 0 
(define-const var712 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var712)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var712!1 String)
(assert (= var712!1 ""))
(assert true)
(define-const var414 String (append/672562846 var712!1 "unsubscribe ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unsubscribe ") 
(declare-const var712!2 String)
(assert (= var712!2 (str.++ var712!1 "unsubscribe ")))
(assert true)
(define-const var2029 String (toFullString/-798704221 var1902)) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var1260 String (append/672562846 var414 var2029)) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var414!1 String)
(assert (= var414!1 (str.++ var414 var2029)))
(assert true)
(define-const var2084 String (toString/-2075883882 var1260)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (multicast/132386392 var3422 var2084)) ; Statement: specialinvoke r3.<org.apache.dubbo.registry.multicast.MulticastRegistry: void multicast(java.lang.String)>($r9) 

(declare-const var3422!1 var312)
(declare-const var2084!1 String)
 ; Statement: return 
(check-sat)
; {getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), multicast/132386392=([org.apache.dubbo.registry.multicast.MulticastRegistry, java.lang.String], void)}
; {var312=org.apache.dubbo.registry.multicast.MulticastRegistry, var3422=r3, var888=org.apache.dubbo.common.URL, var1902=r0, var797=org.apache.dubbo.registry.NotifyListener, var828=r4, var3857=$r2, var3731=$r1, var3900=$z0, var712=$r5, var414=$r6, var2029=$r7, var1260=$r8, var2084=$r9}
; {org.apache.dubbo.registry.multicast.MulticastRegistry=var312, r3=var3422, org.apache.dubbo.common.URL=var888, r0=var1902, org.apache.dubbo.registry.NotifyListener=var797, r4=var828, $r2=var3857, $r1=var3731, $z0=var3900, $r5=var712, $r6=var414, $r7=var2029, $r8=var1260, $r9=var2084}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	r4 := @parameter1: org.apache.dubbo.registry.NotifyListener;	$r2 = "*";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r5 = new java.lang.StringBuilder;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unsubscribe ");	$r7 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r3.<org.apache.dubbo.registry.multicast.MulticastRegistry: void multicast(java.lang.String)>($r9);	return
;block_num 2